Function installIis {
echo IIS aan het installeren... 
CMD /C START /w PKGMGR.EXE /l:log.etw /iu:IIS-WebServerRole
echo klaar! 
}

Function downloaddotnet {
echo ".Net installer aan het downloaden"
$storageDir = "C:\"
$webclient = New-Object System.Net.WebClient
$url = "http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe"
$file = "$storageDir\dotnet.exe"
$webclient.DownloadFile($url,$file)
echo Klaar!
}

Function downloadsql {
echo "Sql installer aan het downloaden..."
$storageDir = "C:\"
$webclient = New-Object System.Net.WebClient
$url = "http://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRWT_x64_ENU.exe"
$file = "$storageDir\sql.exe"
$webclient.DownloadFile($url,$file)
echo Klaar!
}

Function installDotNet {
$ErrorActionPreference = "Stop"

import-module servermanager
echo "Enabling .Net framework"
add-windowsfeature as-net-framework
}

Function installDotNet2 {
echo .Net framework aan het installeren...
C:\dotnet.exe /q
echo Klaar!
}

Function installDotNetT {
Install-WindowsFeature Net-Framework-Core -source C:\dotnet35.exe
}

Function installSQL {
echo Installing SQL Server 2008 Express R2, it will take a while...
C:\sql.exe /Q /Action=install /INDICATEPROGRESS /INSTANCENAME="SQLEXPRESS" /INSTANCEID="SQLExpress" /IAcceptSQLServerLicenseTerms /FEATURES=SQL,Tools /TCPENABLED=1 /SECURITYMODE="SQL" /SAPWD="#SAPassword!"
echo Done!

echo Disabling firewall
netsh advfirewall set allprofiles state off
}

Function confSQL {
$ErrorActionPreference = "Stop"

echo Service aan het restarten
restart-service -f "SQL Server (SQLEXPRESS)"
echo Klaar!
}

installIis
downloaddotnet
downloadsql
installDotNet
installDotNet2
installDotNetT
installSQL
confSQL