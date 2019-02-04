@echo off

:main
	setlocal enabledelayedexpansion
	cd %~dp0
	set iniFile=StaticIPSettings.ini
	call :choice
	goto end

:choice
	echo Choose
	echo [A] Set Static IP
	echo [B] Set DHCP
	echo.
	
	SET /P C=[A,B]?
	for %%? in (A) do if /I "%C%"=="%%?" goto A
	for %%? in (B) do if /I "%C%"=="%%?" goto B
	
	goto choice

:A
	@echo off
	setlocal enabledelayedexpansion
	
	set iniFile=StaticIPSettings.ini
	cd %~dp0
  
	call :get-ini %iniFile% Adapter_Settings Name result
	echo %result%
	set Adapt_Name=%result%
  
	call :get-ini %iniFile% Network_Settings IP_Address result
	echo %result%
	set IP_Addr=%result%
  
	call :get-ini %iniFile% Network_Settings Subnet_Mask result
	echo %result%
	set Sub_Mask=%result%
  
	call :get-ini %iniFile% Network_Settings Default_Gateway result
	echo %result%
	set D_Gate=%result%
  
	echo "Setting Static IP Information" 
	netsh interface ip set address %Adapt_Name% static %IP_Addr% %Sub_Mask% %D_Gate% 1
	
	goto end

:B 
	@echo off  
	setlocal enabledelayedexpansion
	echo Resetting IP Address and Subnet Mask For DHCP

	call :get-ini %iniFile% Adapter_Settings Name result

	set Adapt_Name=%result%
	netsh int ip set address name = "%Adapt_Name%" source = dhcp

	ipconfig /renew
	
	goto end

:get-ini <filename> <section> <key> <result>

set %~4=
setlocal

set file=%~1
set area=[%~2]
set key=%~3
set currarea=
for /f "usebackq delims=" %%a in ("!file!") do (
    set ln=%%a
    if "x!ln:~0,1!"=="x[" (
        set currarea=!ln!
    ) else (
        for /f "tokens=1,2 delims==" %%b in ("!ln!") do (
            set currkey=%%b
            set currval=%%c
            if "x!area!"=="x!currarea!" if "x!key!"=="x!currkey!" (
                endlocal & set %~4=%%c
            )
        )
    )
)
endlocal
	
:end