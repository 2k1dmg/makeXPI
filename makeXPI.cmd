@echo off

REM Инструкция:

REM Этот файл нужно разместить в какой-нибудь папке например "C:\cmdtools" и
REM добавить этот путь в переменные среды Windows. Это позволит запускать его в
REM любой папке.

REM Нужно перейти в нужную папку (например "my-addon-name")
REM например через проводник и зажав "Shift" щёлкнуть правой кнопкой мыши
REM и выбрать "Открыть окно команд". В появившуюся консоль ввести (без кавычек):

REM "makexpi" - создаст дополнение в текущей папке из файлов в текущей папке
REM которые есть в списке переменной "_files".
REM Имя файла будет в таком виде: "my-addon-name-0.2.0-2014-06-20.xpi" т.е
REM имя папки, версия и текущая дата.

REM "makexpi run" - создаст профиль во временной папке Windows в нём создаст
REM файл настроек и дополнение. Это не затронет дополнение в текущей папке.

REM предотвратить запуск при клике по файлу
if "%~dp0"=="%cd%\" (
	title %cd% - makeXPI
	echo.
	echo ‡ ЇгбЄ вм ў Ї ЇЄҐ ¤®Ї®«­Ґ­Ёп зҐаҐ§ "makexpi".
	rem Запускать в папке дополнения через "makexpi".
	rem Run it in addon source folder.
	ping -n 5 127.0.0.1 >nul
	goto :eof
)

REM создать шаблон дополнения
set isInit=%~1
set isWE=%~2
if not "%isInit%"=="init" (
	goto tryToUseExists
)

for /F %%i in ('dir /b /a "%cd%\*"') do (
	echo Error: folder is not empty!
	pause
	goto :eof
)

if "%isWE%"=="we" (
	goto initWE
)
goto initInstallRDF

:initWE
echo.
echo     Init new WebExtension:
echo.

if exist "%~dp0makexpiconf\manifest.json" (
	copy "%~dp0makexpiconf\manifest.json" "%cd%\manifest.json"
	goto manifestJsonDone
)

(
echo {
echo   "manifest_version": 2,
echo   "name": "testXPI",
echo   "description": "testXPI.",
echo   "version": "0.0.1",
echo.
echo   "applications": {
echo     "gecko": {
echo       "id": "testXPI@testXPI.addons.mozilla.org",
echo       "strict_min_version": "45.0.0"
echo     }
echo   },
echo.
echo   "background": {
echo     "scripts": ["background.js"]
echo   }
echo }
)>manifest.json

:manifestJsonDone
if exist "%cd%\manifest.json" (
	echo manifest.json ^(template^) was created!
) else (
	echo Error: manifest.json was not created!
	goto :eof
)

echo.>background.js
echo background.js ^(empty^) was created!

goto :eof

:initInstallRDF
echo.
echo     Init new bootstrapped addon:
echo.

if "%isWE%"=="rdf2" (
	goto initInstallRDF2
)

if exist "%~dp0makexpiconf\install.rdf" (
	copy "%~dp0makexpiconf\install.rdf" "%cd%\install.rdf"
	goto doneInstallRDF
)

(
echo ^<?xml version="1.0"?^>
echo ^<RDF xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
echo 	xmlns:em="http://www.mozilla.org/2004/em-rdf#"^>
echo 	^<Description about="urn:mozilla:install-manifest"^>
echo 		^<em:id^>testXPI@testXPI.addons.mozilla.org^</em:id^>
echo 		^<em:version^>0.0.1^</em:version^>
echo 		^<em:name^>testXPI^</em:name^>
echo 		^<em:creator^>testXPI^</em:creator^>
echo 		^<em:description^>testXPI.^</em:description^>
echo 		^<em:type^>2^</em:type^>
echo 		^<em:bootstrap^>true^</em:bootstrap^>
echo 		^<!-- Firefox --^>
echo 		^<em:targetApplication^>
echo 			^<Description^>
echo 				^<em:id^>{ec8030f7-c20a-464f-9b0e-13a3a9e97384}^</em:id^>
echo 				^<em:minVersion^>24.0^</em:minVersion^>
echo 				^<em:maxVersion^>42.0^</em:maxVersion^>
echo 			^</Description^>
echo 		^</em:targetApplication^>
echo 	^</Description^>
echo ^</RDF^>
)>install.rdf

goto doneInstallRDF

:initInstallRDF2

if exist "%~dp0makexpiconf\install2.rdf" (
	copy "%~dp0makexpiconf\install2.rdf" "%cd%\install.rdf"
	goto doneInstallRDF
)

(
echo ^<?xml version="1.0"?^>
echo ^<RDF:RDF xmlns:em="http://www.mozilla.org/2004/em-rdf#"
echo 		xmlns:NC="http://home.netscape.com/NC-rdf#"
echo 		xmlns:RDF="http://www.w3.org/1999/02/22-rdf-syntax-ns#"^>
echo 	^<RDF:Description RDF:about="urn:mozilla:install-manifest"
echo 		em:id="testXPI@testXPI.addons.mozilla.org"
echo 		em:version="0.0.1"
echo 		em:name="testXPI"
echo 		em:creator="testXPI"
echo 		em:description="testXPI."
echo 		em:type="2"
echo 		em:bootstrap="true"^>
echo 		^<!-- Firefox --^>
echo 		^<em:targetApplication^>
echo 			^<RDF:Description em:id="{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
echo 				em:minVersion="24.0"
echo 				em:maxVersion="42.0" /^>
echo 		^</em:targetApplication^>
echo 	^</RDF:Description^>
echo ^</RDF:RDF^>
)>install.rdf

:doneInstallRDF
if exist "%cd%\install.rdf" (
	echo install.rdf ^(template^) was created!
) else (
	echo Error: install.rdf was not created!
	goto :eof
)

echo.>bootstrap.js
echo bootstrap.js ^(empty^) was created!

echo.>chrome.manifest
echo chrome.manifest ^(empty^) was created!

goto :eof

:tryToUseExists
REM в папке должен быть install.rdf
if not exist "%cd%\install.rdf" (
	if not exist "%cd%\manifest.json" (
		echo.
		echo ЋиЁЎЄ : install.rdf ­Ґ ­ ©¤Ґ­.
		rem Ошибка: install.rdf не найден.
		rem Error: install.rdf not found!
		goto :eof
	)
)

rem enabledelayedexpansion
setlocal enableextensions
if errorlevel 1 (
	echo.
	echo ЋиЁЎЄ : ­Ґ ў®§¬®¦­® ўЄ«озЁвм "enableextensions".
	rem Ошибка: не возможно включить "enableextensions".
	rem Error: Can't enable "enableextensions".
	exit /b 1
)
cls

rem запоминть каталок в котором была выполнена команда
set rundir=%cd%

rem перейти в каталог в котором находится этот cmd файл
cd /d "%~dp0"

rem ==================== Получение информации для продолжения =================

REM путь к своему архиватору 7-Zip (обязательно в кавычках)
REM или 7za.exe в той же папке что и этот файл
rem -------------------------------------------
set archis=
rem -------------------------------------------

set archby=

if "%archis%"=="" goto autoarch
if exist "%archis%" (
	set archby=user
	goto archcomlp1
)
echo.
echo ‚л гЄ § «Ё ­Ґ ўҐа­л© Їгвм Є  аеЁў в®аг.
rem Вы указали не верный путь к архиватору.
rem You set wrong path to archivator.
echo.
ping -n 3 127.0.0.1 >nul
goto :eof

:autoarch

rem использовать 7za.exe
if exist "7za.exe" (
	set archis="%~dp07za.exe"
	set archby=7za
	goto archcomlp1
)

rem получить путь через реестр
set archPath=
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\7-Zip" /v path ^| find "REG_SZ"') do set archPath=%%b
if "%archPath:~-1%"=="\" set archPath=%archPath:~0,-1%
if exist "%archPath%\7z.exe" (
	set archis="%archPath%\7z.exe"
	set archby=reg query
	goto archcomlp1
)

rem использовать установленный 7-Zip
if exist "%PROGRAMFILES%\7-Zip" (
	set archis="%PROGRAMFILES%\7-Zip\7z.exe"
	set archby=programfiles
	goto archcomlp1
)

if exist "%PROGRAMFILES(x86)%\7-Zip" (
	set archis="%PROGRAMFILES(x86)%\7-Zip\7z.exe"
	set archby=programfiles(x86)
	goto archcomlp1
)

rem если 7z прописан в path
7z a "%temp%\%~nx0.7z" -aoa "%~dp0%~nx0"
if not errorlevel 1 (
	set archis=7z
	del /q "%temp%\%~nx0.7z"
	set archby=path
	goto archcomlp1
)
rem для (если 7z прописан в path)
cls
echo Archivator not found!
ping -n 5 127.0.0.1 >nul
goto :eof

:archcomlp1

echo.
echo ЂаеЁў в®а ­ ©¤Ґ­ "%archby%":
rem Архиватор найден:
rem Archivator by "%archby%":
echo %archis%
echo.

set day=%DATE:~0,2%
set month=%DATE:~3,2%
set year=%DATE:~6,4%

REM если час меньше 10 то к нему добавляется пробел, а не ноль
REM поэтому его нужно заменить
REM for /f "delims= " %%x in ("%time%") do set timeNow=0%%x
set timeNow=%TIME: =0%
set hour=%timeNow:~0,2%
set minute=%timeNow:~3,2%
set second=%timeNow:~6,2%

set isRun=%~1

if "%isRun%"=="run" (
	goto packAndRun
) else (
	goto packAddon
)

REM ----------------------------------------------------------------------------
REM общие параметры и "функции"

:packXPI
setlocal
set _exclude=-x!*.xpi -x!*.md -x!*gitignore -x!*hgignore -x!*hgtags -x!*.bat -x!*.cmd -x!*.sh -x!build.xml
set _out_xpi=%1
start "7zip" /b /wait /low %archis% a -tzip %_out_xpi% * -r %_exclude%
if errorlevel 1 (
	echo.
	echo ЋиЁЎЄ :  аеЁў жЁп ­Ґ г¤ « бм.
	rem Ошибка: архивация не удалась.
	rem Error: archivation failed.
	echo Error code: %errorlevel%.
	echo.
	echo archis: %archis%
	echo.
	echo _out_tmp: %_out_tmp%
	echo.
	echo _exclude: %_exclude%
	echo.
	exit /b 1
)
REM goto :eof
if not exist "chrome.manifest" exit /b 0
rem pack JAR
set jarTempFolder=jarTempFolder%year%%month%%day%%hour%%minute%%second%
if exist "%temp%\%jarTempFolder%" rd /s /q "%temp%\%jarTempFolder%"
md "%temp%\%jarTempFolder%"
set jarList=%temp%\%jarTempFolder%\jar_list.txt
echo. 2>"%jarList%"
for /f "tokens=1,2 delims=:!." %%a in (
	'type "chrome.manifest"^|find /i ".jar"'
) do (
	if exist %%~b (
		find "%%~b" "%jarList%">nul
		if errorlevel 1 (
			echo %%~b>>"%jarList%"
		)
	)
)
for /f "usebackq tokens=*" %%a in ("%jarList%") do (
	%archis% a -tzip %temp%\%jarTempFolder%\%%~a.jar .\%%~a\* %_exclude%
	%archis% d %_out_xpi% %%~a
	pushd %temp%\%jarTempFolder%
	%archis% a %_out_xpi% %%~a.jar
	popd
)
rd /s /q "%temp%\%jarTempFolder%"

exit /b 0

:packAddon
echo.
echo ===========================================================================
echo - ‘®§¤ вм ¤®Ї®«­Ґ­ЁҐ.
rem Создать дополнение.
rem Make addon.
echo ===========================================================================
echo.

cd /d "%rundir%"

set currentdir=
for /f "usebackq tokens=*" %%i in (`cd`) do set currentdir=%%~nxi

set curdate=%year%-%month%-%day%

set _out=%currentdir%-%curdate%.xpi

set addonVersion=

if not exist "manifest.json" goto getVersionByInstallRDF
for /f "tokens=1,2 delims=:,	 " %%a in (
	'type "manifest.json"^|find /i "version"'
) do (
	if %%~a==version (
		set addonVersion=%%~b
	)
)
if not "%addonVersion%"=="" goto addonVersionDone

:getVersionByInstallRDF
for /f "tokens=3 delims=<>" %%a in (
	'type "install.rdf"^|find /i "<em:version>"'
) do set addonVersion=%%~a
if not "%addonVersion%"=="" goto addonVersionDone

for /f "tokens=3 delims=<>" %%a in (
	'type "install.rdf"^|find /i "<version>"'
) do set addonVersion=%%~a
if not "%addonVersion%"=="" goto addonVersionDone

setlocal EnableDelayedExpansion
for /f "tokens=* usebackq" %%a in (
	`type "install.rdf"^|find /i "em:version"`
) do (
    set z=%%a
    set z=!z:"=_!
    for /f "tokens=1-3 delims=_" %%a in ("!z!") do set _addonVersion=%%b
)
endlocal & set addonVersion=%_addonVersion%
:addonVersionDone

if not "%addonVersion%"=="" (
	set _out=%currentdir%-%addonVersion%.xpi
)

rem временный файла во временной папке Windows
set _out_tmp=%temp%\%_out%.tmp

call :packXPI "%_out_tmp%"
if errorlevel 1 goto :eof

if not exist %_out% goto skipCompare
fc /l /lb2 /t %_out% %_out_tmp% >nul
if "%errorlevel%"=="0" goto noUpdateAddonXPI
if "%errorlevel%"=="1" goto updateAddonXPI

echo.
echo ЋиЁЎЄ  ЇаЁ ба ў­Ґ­ЁЁ.
rem Ошибка при сравнении.
rem Error: compare.
echo.
echo _out: %_out%
echo.
echo _out_tmp: %_out_tmp%
echo.
goto :eof

:noUpdateAddonXPI
echo ========================================
echo ==^> €§¬Ґ­Ґ­Ё© ­Ґв!
rem Изменений нет!
rem No changes!
echo ========================================
del "%_out_tmp%"
goto :eof

:updateAddonXPI
echo ========================================
echo ==^> €§¬Ґ­Ґ­Ёп, ®Ў­®ў«Ґ­ЁҐ...
rem Изменения, обновление...
rem Changed, update...
echo ========================================
goto moveAddonXPI

:skipCompare
echo ========================================
echo ==^> ‘®§¤ ­®.
rem Создано.
rem Created.
echo ========================================

:moveAddonXPI
move /y "%_out_tmp%" "%rundir%\%_out%"
goto :eof


:packAndRun
echo.
echo ===========================================================================
echo - ‘®§¤ вм ¤®Ї®«­Ґ­ЁҐ Ё § ЇгбвЁвм Firefox б ­Ё¬.
rem Создать дополнение и запустить Firefox с ним.
rem Make addon and run Firefox with it.
echo ===========================================================================
echo.

REM ----------------------------------------------------------------------------
REM создание профиля во временной папке

cd /d %temp%

set runTempProf=makeXPIrun%year%%month%%day%%hour%%minute%%second%

md %runTempProf%
if not errorlevel 1 goto cdInRunTempProf
echo.
echo ЋиЁЎЄ  ЇаЁ б®§¤ ­ЁЁ ўаҐ¬Ґ­­® Їа®дЁ«п.
rem Ошибка при создании временно профиля.
rem Error: runTempProf.
echo.
echo runTempProf: %runTempProf%
echo.
cd /d "%rundir%"
goto :eof

:cdInRunTempProf
cd %runTempProf%
echo.
echo ‚аҐ¬Ґ­­л© Їа®дЁ«м б®§¤ ­:
rem Временный профиль создан:
rem Temporary profile created:
echo "%temp%\%runTempProf%"

md extensions

if exist "%~dp0makexpiconf\user.js" (
	copy "%~dp0makexpiconf\user.js" "%temp%\%runTempProf%\user.js"
	goto userJsDone
)

REM настройки user.js взятые из Addon SDK 1.6
echo. > user.js

echo user_pref("devtools.errorconsole.enabled", true);>> user.js
REM https://developer.mozilla.org/en-US/Add-ons/Add-on_Debugger
echo user_pref("devtools.chrome.enabled", true);>> user.js
echo user_pref("devtools.debugger.remote-enabled", true);>> user.js

echo user_pref("javascript.options.showInConsole", true);>> user.js
echo user_pref("javascript.options.strict", true);>> user.js

echo user_pref("extensions.autoDisableScopes", 10);>> user.js
echo user_pref("extensions.enabledScopes", 5);>> user.js
echo user_pref("extensions.sdk.console.logLevel", "info");>> user.js
echo user_pref("extensions.installDistroAddons", false);>> user.js
echo user_pref("extensions.getAddons.cache.enabled", false);>> user.js
echo user_pref("extensions.update.enabled", false);>> user.js
echo user_pref("extensions.checkCompatibility.nightly", false);>> user.js
echo user_pref("extensions.blocklist.url", "http://localhost/extensions-dummy/blocklistURL");>> user.js
echo user_pref("extensions.update.notifyUser", false);>> user.js
echo user_pref("extensions.update.url", "http://localhost/extensions-dummy/updateURL");>> user.js
echo user_pref("extensions.webservice.discoverURL", "http://localhost/extensions-dummy/discoveryURL");>> user.js

echo user_pref("browser.shell.checkDefaultBrowser", false);>> user.js
echo user_pref("browser.safebrowsing.provider.0.updateURL", "http://localhost/safebrowsing-dummy/update");>> user.js
echo user_pref("browser.sessionstore.resume_from_crash", false);>> user.js
echo user_pref("browser.warnOnQuit", false);>> user.js
echo user_pref("browser.safebrowsing.provider.0.gethashURL", "http://localhost/safebrowsing-dummy/gethash");>> user.js
echo user_pref("browser.tabs.warnOnClose", false);>> user.js
echo user_pref("browser.dom.window.dump.enabled", true);>> user.js
echo user_pref("browser.startup.homepage", "about:blank");>> user.js

echo user_pref("app.update.enabled", false);>> user.js
echo user_pref("urlclassifier.updateinterval", 172800);>> user.js
echo user_pref("startup.homepage_welcome_url", "about:blank");>> user.js

echo user_pref("xpinstall.signatures.required", false);>> user.js
echo user_pref("xpinstall.whitelist.required", false);>> user.js

rem дополнительно
rem перевести плагины в режим "click to play"
echo. >> user.js
echo user_pref("plugin.default.state", 1);>> user.js
echo user_pref("plugin.state.flash", 1);>> user.js
REM отключить знакомство с новинками
echo user_pref("browser.uitour.enabled", false);>> user.js

:userJsDone
REM ----------------------------------------------------------------------------
REM создание дополнения

cd /d "%rundir%"

REM т.к в install.rdf кроме ID дополнения есть ещё и ID программ с которыми
REM совместимо это дополнение. Первый как правило и есть нужный ID.
set addonID=

for /f "tokens=1,2 delims=:,	 " %%a in (
	'type "manifest.json"^|find /i "id"'
) do (
	if %%~a==id (
		set addonID=%%~b&goto checkAddonID
	)
)

for /f "tokens=3 delims=<>" %%a in (
	'type "install.rdf"^|find /i "<em:id>"'
) do set addonID=%%a&goto checkAddonID

for /f "tokens=3 delims=<>" %%a in (
	'type "install.rdf"^|find /i "<id>"'
) do set addonID=%%a&goto checkAddonID

setlocal EnableDelayedExpansion
for /f "tokens=* usebackq" %%a in (
	`type "install.rdf"^|find /i "em:id"`
) do (
    set z=%%a
    set z=!z:"=_!
    for /f "tokens=1-3 delims=_" %%a in ("!z!") do set _addonID=%%b&goto _addonIDDone
)
:_addonIDDone
endlocal & set addonID=%_addonID%

:checkAddonID
if "%addonID%"=="" (
	echo.
	echo Addon ID not found!
	goto :eof
)

set _out="%temp%\%runTempProf%\extensions\%addonID%.xpi"

call :packXPI "%_out%"
if errorlevel 1 goto :eof

set addonUnpack=

if not exist "install.rdf" goto addonUnpackDone

for /f "tokens=3 delims=<>" %%a in (
	'type "install.rdf"^|find /i "<em:unpack>"'
) do set addonUnpack=%%a
if not "%addonUnpack%"=="" goto addonUnpackDone

for /f "tokens=3 delims=<>" %%a in (
	'type "install.rdf"^|find /i "<unpack>"'
) do set addonUnpack=%%a
if not "%addonUnpack%"=="" goto addonUnpackDone

setlocal EnableDelayedExpansion
for /f "tokens=* usebackq" %%a in (
	`type "install.rdf"^|find /i "em:unpack"`
) do (
    set z=%%a
    set z=!z:"=_!
    for /f "tokens=1-3 delims=_" %%a in ("!z!") do set _addonUnpack=%%b
)
endlocal & set addonUnpack=%_addonUnpack%
:addonUnpackDone

if not "%addonUnpack%"=="true" goto addonUnpackFalse
rem если это дополнение с перезапуском
start "7zip" /b /wait /low %archis% x "%temp%\%runTempProf%\extensions\%addonID%.xpi" -o"%temp%\%runTempProf%\extensions\%addonID%"
if errorlevel 1 (
	echo.
	echo ЋиЁЎЄ : а бЇ Є®ўЄ  ­Ґ г¤ « бм.
	rem Ошибка: распаковка не удалась.
	rem Error: extraction failed.
	echo Error code: %errorlevel%.
	echo.
	echo archis: %archis%
	echo.
	echo file: "%temp%\%runTempProf%\extensions\%addonID%.xpi"
	echo.
	goto cleanRunTempProf
)
del "%temp%\%runTempProf%\extensions\%addonID%.xpi"
:addonUnpackFalse

ping -n 2 127.0.0.1 >nul

echo.
echo Addon params
echo ====================
echo addonID: "%addonID%"
echo addonUnpack: "%addonUnpack%"
echo ====================

REM ----------------------------------------------------------------------------
REM запуск firefox
rem ============================================================================
set firefox=
rem ============================================================================
REM или свой путь к файлу firefox.exe (обязательно в кавычках)
REM например
REM set firefox="F:\PAP\PortableApps\FirefoxPortableNightly64\App\core\firefox.exe"

REM дополнительный параметр
REM makexpi run beta
REM или в кавычках путь к firefox.exe
REM makexpi run "F:\PAP\PortableApps\FirefoxPortableNightly\App\core\firefox.exe"
set firefox_bin=%~2

if "%firefox_bin%"=="" goto getFirefox
goto getFirefoxParam2

:getFirefox
if not "%firefox%"=="" goto checkIsExistFirefox

echo.
set firefoxRegPath=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe
reg query "%firefoxRegPath%" > nul
if errorlevel 1 (
	echo.
	echo ЋиЁЎЄ : ­Ґ ­ ©¤Ґ­ Firefox!
	rem Ошибка: не найден Firefox!
	rem Firefox not installed?
	goto cleanRunTempProf
)
set firefoxPath=
for /f "tokens=2*" %%a in ('reg query "%firefoxRegPath%" /v path ^| find "REG_SZ"') do set firefoxPath=%%b
if "%firefoxPath:~-1%"=="\" set firefoxPath=%firefoxPath:~0,-1%
set firefox=%firefoxPath%\firefox.exe
goto checkIsExistFirefox

:getFirefoxParam2

if not exist "%~dp0makexpiconf\bins.txt" goto useBuiltInConf

for /f "tokens=1,2* delims==" %%a in ('type "%~dp0makexpiconf\bins.txt"') do (
	if %firefox_bin%==%%~a (
		set firefox=%%~b
		goto checkIsExistFirefox
	)
)
goto skipBuiltInConf

:useBuiltInConf
REM здесть нужно выставить свои пути к файлам если они есть
REM или добавить ещё
if "%firefox_bin%"=="esr" (
	set firefox=D:\PAP\PortableApps\FirefoxPortableESR\App\Firefox\firefox.exe
	goto checkIsExistFirefox
)
if "%firefox_bin%"=="beta" (
	set firefox=D:\PAP\PortableApps\FirefoxPortableTest\App\Firefox\firefox.exe
	goto checkIsExistFirefox
)
if "%firefox_bin%"=="aurora" (
	set firefox=D:\PAP\PortableApps\FirefoxPortableAurora\App\core\firefox.exe
	goto checkIsExistFirefox
)
if "%firefox_bin%"=="nightly" (
	set firefox=D:\PAP\PortableApps\FirefoxPortableNightly\App\firefox\firefox.exe
	goto checkIsExistFirefox
)
if "%firefox_bin%"=="nightly64" (
	set firefox=D:\PAP\PortableApps\FirefoxPortableNightly64\App\core\firefox.exe
	goto checkIsExistFirefox
)

rem SeaMonkey
if "%firefox_bin%"=="sm" (
	set firefox=D:\PAP\PortableApps\SeaMonkeyPortable\App\SeaMonkey\seamonkey.exe
	goto checkIsExistFirefox
)

rem PaleMoon
if "%firefox_bin%"=="pm" (
	set firefox=D:\PAP\PortableApps\PalemoonPortable\Bin\Palemoon\palemoon.exe
	goto checkIsExistFirefox
)

:skipBuiltInConf

if not "%firefox_bin%"=="" (
	set firefox=%firefox_bin%
	goto checkIsExistFirefox
)

goto startFirefox

:checkIsExistFirefox
if not exist "%firefox%" (
	echo.
	echo ЋиЁЎЄ : "%firefox%" ­Ґ ­ ©¤Ґ­!
	rem Ошибка: %firefox% не найден!
	rem Error: %firefox% not found!
	goto cleanRunTempProf
)

:startFirefox

echo.
echo Џгвм Є Firefox:
rem Путь к Firefox:
rem Firefox path:
echo "%firefox%"
echo.

REM если в том же каталоге в котором находится makeXPI есть Console Redirector
REM то вывод в консоль будет через него. Иначе можно добавить -console к
REM параметрам и при запуске появится дополнительная консоль Firefox
REM https://developer.mozilla.org/en-US/docs/Web/API/Window.dump
if exist "%~dp0Console Redirector\Console Redirector.exe" goto ConsoleRedirector
start "Firefox" /b /wait "%firefox%" -no-remote -profile "%temp%\%runTempProf%"
goto cleanRunTempProf

:ConsoleRedirector
echo.
echo ===========================================================================
echo - Start - Console Redirector -
echo ===========================================================================
echo.
start "Firefox" /b /wait "%~dp0Console Redirector\Console Redirector.exe" "%firefox%" -no-remote -profile "%temp%\%runTempProf%"
echo.
echo ===========================================================================
echo - End - Console Redirector -
echo ===========================================================================
echo.

:cleanRunTempProf
ping -n 3 127.0.0.1 >nul
REM удалить временный профиль после выхода из firefox
rd /s /q "%temp%\%runTempProf%"
if errorlevel 1 (
	echo.
	echo ЋиЁЎЄ  ЇаЁ г¤ «Ґ­ЁЁ ўаҐ¬Ґ­­®Ј® Їа®дЁ«п.
	rem Ошибка при удалении временного профиля.
	rem Error: temporary profile remove.
) else (
	echo.
	echo ‚аҐ¬Ґ­­л© Їа®дЁ«м г¤ «с­.
	rem Временный профиль удалён.
	rem The temporary profile was removed.
)

cd /d "%rundir%"
goto :eof

