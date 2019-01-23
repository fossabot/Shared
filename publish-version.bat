@ECHO OFF

REM Publishing assumes the shared repo is at the same directory level as all other components
echo (c) HQ.IO
echo:

for /F "USEBACKQ TOKENS=*" %%b in ("%~dp0_manifest\components.txt") do (

	echo:
	echo Updating version for %%b...
	echo ================================================
	echo:
	
	REM update all version files
	xcopy /f /s /y "build\version.props" "%~dp0..\%%b\build\version.props*" |find /v "File(s) copied"
)
echo:
echo Done.
echo:
