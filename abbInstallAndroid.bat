@echo off

:: bundletool.jar 路徑
set bundletool=bundletool.jar

:: 選擇 Android 安裝 .aab or .apks
:begin
echo.
echo 1) Install .aab to Android
echo 2) Install .apks to Android
echo.
choice /c:12 /n /m "Select your want execute command (1 or 2)?"
goto installAndroid%errorlevel%

:installAndroid1

set /p aabPath=Please enter (.aab) path: 
set apksPath=%aabPath:~0,-4%.apks
if exist %apksPath% rm react_native.apks
set /p ksPath=Please enter keystore.jks path: 
set /p ksPass=Please enter keystore password: 
set /p keyAlias=Please enter key alias: 
set /p keyPass=Please enter key password: 

%bundletool% build-apks^
	--bundle=%aabPath%^
	--output=%aabPath:~0,-4%.apks^
	--ks=%ksPath%^
	--ks-pass=pass:%ksPass%^
	--ks-key-alias=%keyAlias%^
	--key-pass=pass:%keyPass%
	
%bundletool% install-apks --apks=%aabPath:~0,-4%.apks

goto end

:installAndroid2

set /p apksPath=Please enter (.apks) path: 
%bundletool% install-apks --apks=%apksPath%

goto end
:end

echo. & pause