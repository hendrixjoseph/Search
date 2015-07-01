@echo off

setlocal enabledelayedexpansion

rem Set search term here. xml is just an example.
set searchterm=xml

echo ^<html^>^<head^>^<title^>Search For Phrase %searchterm%^<^/title^>^<^/head^>^<body^>Search For Phrase %searchterm%^<br ^/^>^<br ^/^> > search.html

set n=0

for /R %%G in (*) do (

	if NOT "%%G"=="%CD%\search.bat" if NOT "%%G"=="%CD%\search.html" (
		set "subpath=%%G"
		set "subpath=!subpath:%CD%\=!"

		(findstr "%searchterm%" "!subpath!" > NUL || echo !subpath! | findstr "%searchterm%" > NUL) && (
		
			set /a n=!n!+1	

			set "htmlVar=!htmlVar!^<a href^=^"%%~pG^"^>%%G^<^/a^>^<br ^/^>"

			for /f "tokens=*" %%h in ('findstr "%searchterm%" "!subpath!"') do (

				set "str=%%h"
				set "str=!str:<=&lt;!"
				set "str=!str:>=&gt;!"
				set "htmlVar=!htmlVar!!str!<br ^/^>"
			)

			set "htmlVar=!htmlVar!^<br ^/^>"
		)
	)
)

if !n!==1 (
	echo !n! file found with match.^<br ^/^>^<br ^/^> >> search.html
) else (
	echo !n! files found with match.^<br ^/^>^<br ^/^> >> search.html
)

if defined htmlVar (
	echo !htmlVar! >> search.html
)

echo ^<^/body^>^<^/html^> >> search.html

start search.html
