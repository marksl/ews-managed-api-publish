rd /s /q ews-managed-api
 
:: clone repo
git clone https://github.com/OfficeDev/ews-managed-api.git ews-managed-api
git checkout 25a393dbc68b420d25999bdf0a03c23d86412f57
 
copy Microsoft.Exchange.WebServices.Data.nuspec ews-managed-api
 
:: https://docs.microsoft.com/en-us/visualstudio/install/tools-for-managing-visual-studio-instances
FOR /f "usebackq tokens=*" %%i IN (
    `vswhere -version ^[15.0^,16.0^) -products * -requires Microsoft.Component.MSBuild -property installationPath`
) DO (SET VSINSTALLDIR=%%i)
 
:: VS 2017 Tools Command Prompt
CALL "%VSINSTALLDIR%\Common7\Tools\VsDevCmd.bat"
 
:: Displays 15.6.82.30579
msbuild -version
 
msbuild ews-managed-api\Microsoft.Exchange.WebServices.Data.csproj /p:Configuration=Debug

powershell -Command "Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile nuget.exe"
 
nuget.exe pack ews-managed-api\Microsoft.Exchange.WebServices.Data.csproj
