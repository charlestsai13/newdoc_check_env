$min_ver = "3.0.3"
$dir = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$hicos_utility = $dir+"\Chunghwa Telecom\HiCOS PKI Smart Card\TokenUtility.exe"

function install_hicos{
	# Only for powershell 5+
	# Invoke-WebRequest -Uri http://api-hisecurecdn.cdn.hinet.net/HiCOS_Client.zip -outFile ${env:Temp}\hicos.zip
	# Expand-Archive -Force ${env:Temp}\hicos.zip -DestinationPath ${env:Temp}\

	# download hicos
	$hicos_url = "http://api-hisecurecdn.cdn.hinet.net/HiCOS_Client.zip" 
	$hicos_local = "${env:Temp}\hicos.zip" 
	(New-Object Net.WebClient).DownloadFile($hicos_url, $hicos_local) 

	# unzip hicos
	$shell_app=new-object -com shell.application
	$zip_file = $shell_app.namespace(${env:Temp} + "\hicos.zip")
	$destination = $shell_app.namespace(${env:Temp})
	$destination.Copyhere($zip_file.items(), 0x14)
	& ${env:Temp}\HiCOS_Client.exe
}

function check_hicos_ver{
    $h_ver = (Get-Item $hicos_utility).VersionInfo.FileVersion -replace ",","." -replace " ","" -split "\."
    $min_ver = $min_ver -split "\."
    if ($h_ver[0] -ge $min_ver[0]){
        if ($h_ver[1] -ge $min_ver[1]){
    	    if ($h_ver[2] -ge $min_ver[3]){
    		    echo "hicos version ok!"
    	    } else { install_hicos }
        } else { install_hicos }
    } else { install_hicos }
}

if (Test-Path $hicos_utility){
	check_hicos_ver
} else {
	install_hicos
}