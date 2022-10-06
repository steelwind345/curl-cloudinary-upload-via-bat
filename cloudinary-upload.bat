
set APIKEY=""
set UploadPreset=""
set CloudName=""

setlocal
call :GetUnixTime UNIX_TIME

:GetUnixTime
setlocal enableextensions
for /f %%x in ('wmic path win32_utctime get /format:list ^| findstr "="') do (
    set %%x)
set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
set /a ut=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
endlocal 

for %%f in (*.jpg) do (
curl.exe -k https://api.cloudinary.com/v1_1/%CloudName%/image/upload -X POST -F file=@%%~nxf -F public_id=%%~nf -F timestamp=%UNIX_TIME% -F api_key=%APIKEY% -F upload_preset=%UploadPreset%
)

pause