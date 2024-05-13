@echo off
REM set Inputfile, where you have list of all domain users
set inputFile=C:\Users\poor.victim\Desktop\users.txt

REM set ouputfiles, manually create these empty files, before running this script
set activeUsers=C:\Users\poor.victim\Desktop\activeUsersDomain.txt
set notactiveUsers=C:\Users\poor.victim\Desktop\notactiveUsersDomain.txt

REM counter, to count
set /a counter=1


for /f "delims=" %%u in (%inputFile%) do (
    echo Processing user: %%u
    for /f "tokens=2*" %%a in ('net user %%u /domain ^| findstr /C:"Account active"') do (

		if /I "%%b"=="Yes" (
            echo User %%u is active
			echo %%u >> %activeUsers%
			set /a counter = counter + 1 
			echo.
        ) else (
            echo User %%u is not active
			echo %%u >> %notactiveUsers%
			set /a counter = counter + 1  
			echo.
        )
	 
   )
	REM add a delay of 3 seconds for each attempt
    timeout /t 3 >nul

)
