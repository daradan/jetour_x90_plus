@chcp 1251
@echo off
setlocal enabledelayedexpansion
set "close_after_each=false"
rem:Вывод Меню
:MENU
cls
color 0f
echo       dP                                  dP                   
echo       88                                  88                   
echo .d888b88 .d8888b. 88d888b. .d8888b. .d888b88 .d8888b. 88d888b. 
echo 88'  `88 88'  `88 88'  `88 88'  `88 88'  `88 88'  `88 88'  `88 
echo 88.  .88 88.  .88 88       88.  .88 88.  .88 88.  .88 88    88 
echo `88888P8 `88888P8 dP       `88888P8 `88888P8 `88888P8 dP    dP 
echo.                                                        
echo  Установка приложений в ГУ Jetour X90 Plus 2.0 по ADB
echo -------------------------------------------------------
echo Перед началом процесса подключения к ГУ и установки приложений, необходимо включить в ГУ отладку по USB.
echo Для этого требуется выполнить следующие операции:
rem echo. 
echo  A. Заходим в приложение "Телефон" на ГУ и в номеронаберателе вводим *621317658# или *20220730#;
echo  B. В открывшемся окне нажимаем на плитку USB, затем выбираем Device и нажимаем в левом углу OK
echo  C. Устанавливаем драйвер устройства ADB (используем установочный пакет Samsung Driver из меню ниже (пункт 1.)
echo  D. После установки драйвера подключаем ГУ к ноутбуку кабелем USB-A - USB-A
rem echo. 
echo -------------------------------------------------------
echo  [93mМеню установки приложений в ГУ Jetour X90 Plus[0m
echo -------------------------------------------------------
rem echo.
echo  [96m1.Установка драйвера ADB (Samsung Driver)[0m
echo  [96m2.Проверить соединенние с ГУ по ADB[0m
echo  [96m3.Установка (Android Auto - Headunit reloaded)[0m
echo  [96m4.Установка (ATV Launcher)[0m
echo  [96m5.Установка (Back Button Anywhere)[0m
echo  [96m6.Установка (File Manager)[0m
echo  [96m7.Установка (X-Plore)[0m
echo  [96m8.Установка (Yandex Navigator)[0m
echo  [96m9.Установка (MapCamDroid)[0m
echo  [96m10.Установка (HUD Antiradar)[0m
echo  [96m11.Установка (Yandex Music)[0m
echo  [96m12.Установка (Spotify)[0m
echo  [96m13.Установка (Poweramp Equilizer)[0m
echo  [96m14.Установка (vYouTube)[0m
echo  [96m15.Установка (MacroDroid)[0m
echo  [96m16.Установка всех приложении[0m
echo  [96m17.Запуск Android Auto (выбирать только после установки)[0m
echo  [96m18.Запуск ATV Launcher (выбирать только после установки)[0m
echo  [96m19.Запуск Back Button Anywhere (выбирать только после установки)[0m
echo  [96m20.Выход[0m 
echo -------------------------------------------------------                 
set /p Xz=Выберите необходимый пункт меню установки приложений:
if "%Xz%"=="1" goto drivers
if "%Xz%"=="2" goto devices
if "%Xz%"=="3" goto thirdapp_aa
if "%Xz%"=="4" goto thirdapp_atvl
if "%Xz%"=="5" goto thirdapp_bba
if "%Xz%"=="6" goto thirdapp_fm
if "%Xz%"=="7" goto thirdapp_xp
if "%Xz%"=="8" goto thirdapp_yn
if "%Xz%"=="9" goto thirdapp_mc
if "%Xz%"=="10" goto thirdapp_ha
if "%Xz%"=="11" goto thirdapp_ym
if "%Xz%"=="12" goto thirdapp_sp
if "%Xz%"=="13" goto thirdapp_pe
if "%Xz%"=="14" goto thirdapp_yt
if "%Xz%"=="15" goto thirdapp_md
if "%Xz%"=="16" set "close_after_each=true" & goto thirdapp_all
if "%Xz%"=="17" goto thirdapp_run_aa
if "%Xz%"=="18" goto thirdapp_run_atvl
if "%Xz%"=="19" goto thirdapp_run_bba
if "%Xz%"=="20" goto eexit

rem:Установка драйверов для ADB
:drivers
cls
start adb_run.exe
TIMEOUT /T 3
goto MENU


rem:Проверка подключения по ADB
:devices
cls
echo  [96mПроверка подключения к ГУ по ADB[0m  
echo.
setlocal enabledelayedexpansion

REM Run your command and store the output in a variable
for /f "delims=" %%A in ('adb devices') do (
    set /a count+=1
    if !count! equ 2 (
        set "output=%%A"
        goto :check_second_line
    )
)

:check_second_line
REM Check if the second line contains "device"
echo %output% | findstr /C:"device" > nul
if %errorlevel% equ 0 (
	echo.
    echo %output%
    echo.
    echo  [92mСоединенние с ГУ успешно установленно, можно переходить к следующему этапу^^![0m 
    echo.
) else (
    echo  [91mСоединение с ГУ не установленно^^![0m 
    echo.
    echo Проверьте кабель подключения к ГУ, установку драйвера ADB и правильность включения режима ADB в ГУ.
    echo.
)

endlocal
pause
goto MENU

:thirdapp_aa
rem:Установка Android Auto - Headunit reloaded
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/aa_jetour_x90_plus.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение Android Auto - Headunit reloaded...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/aa_jetour_x90_plus.apk
TIMEOUT /T 4 > nul
rem echo.
rem echo [95mЗапускаем приложение Android Auto - Headunit reloaded...[0m 
rem echo.
rem adb shell am start -n gb.xxy.hr/gb.xxy.hr.activities.DispatcherActivity
echo [92mУстановка Android Auto - Headunit reloaded завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_atvl
rem:Установка ATV Launcher
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/atv_launcher.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение ATV Launcher...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/atv_launcher.apk
TIMEOUT /T 4 > nul
rem echo.
rem echo [95mЗапускаем приложение Android Auto - Headunit reloaded...[0m 
rem echo.
rem adb shell am start -n ca.dstudio.atvlauncher/ca.dstudio.atvlauncher.screens.launcher.LauncherActivity
rem echo.
echo [92mУстановка ATV Launcher завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_bba
rem:Установка Back Button Anywhere
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/back_button_anywhere.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение Back Button Anywhere...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/back_button_anywhere.apk
TIMEOUT /T 4 > nul
echo [95mВыдаём необходимые разрешения...[0m 
adb shell settings put secure enabled_accessibility_services nu.back.button/nu.back.button.BackButtonService
TIMEOUT /T 3 > nul
echo.
rem echo.
rem echo [95mЗапускаем приложение Back Button Anywhere...[0m 
rem adb shell am start -n nu.back.button/nu.back.button.activity.WelcomeActivity
rem echo.
echo [92mУстановка Back Button Anywhere завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

rem :thirdapp_at
rem rem:Установка Assistive Touch
rem adb root
rem TIMEOUT /T 3 > nul
rem adb remount
rem TIMEOUT /T 3 > nul
rem echo.
rem echo [95mКопируем файл APK во временную папку ГУ...[0m 
rem adb push app/assistive_touch.apk /data/local/tmp
rem TIMEOUT /T 3 > nul
rem echo.
rem echo [95mУстанавливаем приложение Assistive Touch...[0m 
rem echo.
rem TIMEOUT /T 2 > nul
rem adb shell pm install /data/local/tmp/assistive_touch.apk
rem TIMEOUT /T 4 > nul
rem echo [92mУстановка Assistive Touch завершена![0m
rem echo.
rem if "%close_after_each%"=="false" goto MENU
rem exit /b

:thirdapp_fm
rem:Установка File Manager
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/file_manager.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение File Manager...[0m 
echo.
adb shell pm install /data/local/tmp/file_manager.apk
TIMEOUT /T 4 > nul
echo [95mВыдаём необходимые разрешения...[0m 
adb shell pm grant com.alphainventor.filemanager android.permission.WRITE_EXTERNAL_STORAGE
rem TIMEOUT /T 3 > nul
adb shell appops set com.alphainventor.filemanager REQUEST_INSTALL_PACKAGES allow
echo.
TIMEOUT /T 2 > nul
echo [92mУстановка File Manager завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_xp
rem:Установка X-Plore
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/x_plore.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение X-Plore...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/x_plore.apk
TIMEOUT /T 4 > nul
echo [92mУстановка X-Plore завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_yn
rem:Установка Yandex Navigator
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/yandex_navigator.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение Yandex Navigator...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/yandex_navigator.apk
TIMEOUT /T 4 > nul
echo [92mУстановка Yandex Navigator завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_mc
rem:Установка MapCamDroid
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/info_mapcam.droidapk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение MapCamDroid...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/info_mapcamdroid.apk
TIMEOUT /T 4 > nul
echo [92mУстановка MapCamDroid завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_ha
rem:Установка HUD Antiradar
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/hud_antiradar.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение HUD Antiradar...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/hud_antiradar.apk
TIMEOUT /T 4 > nul
echo [92mУстановка HUD Antiradar завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_ym
rem:Установка Yandex Music
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/yandex_music.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение Yandex Music...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/yandex_music.apk
TIMEOUT /T 4 > nul
echo [92mУстановка Yandex Music завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_sp
rem:Установка Spotify
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/spotify.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение Spotify...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/spotify.apk
TIMEOUT /T 4 > nul
echo [92mУстановка Spotify завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_pe
rem:Установка Poweramp Equilizer
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/poweramp_equalizer.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение Poweramp Equilizer...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/poweramp_equalizer.apk
TIMEOUT /T 4 > nul
echo [92mУстановка Poweramp Equilizer завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

:thirdapp_yt
rem:Установка vYouTube
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mКопируем файл APK во временную папку ГУ...[0m 
adb push app/vyoutube.apk /data/local/tmp
TIMEOUT /T 3 > nul
echo.
echo [95mУстанавливаем приложение vYouTube...[0m 
echo.
TIMEOUT /T 2 > nul
adb shell pm install /data/local/tmp/vyoutube.apk
TIMEOUT /T 4 > nul
echo [92mУстановка vYouTube завершена![0m
echo.
if "%close_after_each%"=="false" goto MENU
exit /b

rem :filemanager_tc
rem rem:Установка файлового менеджера Total Commander
rem cls
rem adb root
rem TIMEOUT /T 3 > nul
rem adb remount
rem TIMEOUT /T 3 > nul
rem echo.
rem echo [95mКопируем файл APK во временную папку ГУ...[0m 
rem adb push tc.apk /data/local/tmp
rem TIMEOUT /T 3 > nul
rem echo.
rem echo [95mУстанавливаем приложение файлового менеджера...[0m 
rem echo.
rem TIMEOUT /T 2 > nul
rem adb shell pm install /data/local/tmp/tc.apk < password.txt
rem TIMEOUT /T 4 > nul
rem echo [95mВыдаём необходимые разрешения...[0m 
rem adb shell pm grant com.ghisler.android.TotalCommander android.permission.WRITE_EXTERNAL_STORAGE < password.txt
rem TIMEOUT /T 3 > nul
rem adb shell appops set com.ghisler.android.TotalCommander REQUEST_INSTALL_PACKAGES allow < password.txt
rem echo.
rem TIMEOUT /T 3 > nul
rem echo.
rem echo [95mОчищаем кэш лаунчера...[0m 
rem adb shell rm -rf /data/data/com.iflytek.autofly.launcher/cache/* < password.txt
rem echo.
rem TIMEOUT /T 2 > nul
rem echo.
rem echo [92mУстановка файлового менеджера "Total Commander" завершена![0m
rem echo.
rem 
rem pause
rem goto MENU

:thirdapp_all
rem Выполнить установку приложений с 3 по 15
call :thirdapp_aa
call :thirdapp_atvl
call :thirdapp_bba
call :thirdapp_fm
call :thirdapp_xp
call :thirdapp_yn
call :thirdapp_mc
call :thirdapp_ha
call :thirdapp_ym
call :thirdapp_sp
call :thirdapp_pe
call :thirdapp_yt
call :thirdapp_md
set "close_after_each=false"
goto MENU

:thirdapp_run_aa
rem:Запускаем Android Auto - Headunit reloaded
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mЗапускаем приложение Android Auto - Headunit reloaded...[0m
adb shell am start -n gb.xxy.hr/gb.xxy.hr.activities.DispatcherActivity 
echo.
echo [92mУстановка Android Auto - Headunit reloaded завершена![0m
echo.
exit /b

:thirdapp_run_atvl
rem:Запускаем ATV Launcher
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mЗапускаем приложение Android Auto - Headunit reloaded...[0m 
echo.
adb shell am start -n ca.dstudio.atvlauncher/ca.dstudio.atvlauncher.screens.launcher.LauncherActivity
echo.
echo [Запуск ATV Launcher завершена![0m
echo.
exit /b

:thirdapp_run_bba
rem:Установка Back Button Anywhere
adb root
TIMEOUT /T 3 > nul
adb remount
TIMEOUT /T 3 > nul
echo.
echo [95mЗапускаем приложение Back Button Anywhere...[0m 
adb shell am start -n nu.back.button/nu.back.button.activity.WelcomeActivity
echo.
echo [Запуск Back Button Anywhere завершена![0m
echo.
exit /b


:eexit
cls
exit