@ECHO OFF

REM Publishing assumes the shared repo is at the same directory level as all other components
echo (c) HQ.IO 
echo:

REM copy packaging project files
xcopy /f /s /y "rebuild.cmd" "%~dp0..\HQ\rebuild.cmd*" |find /v "File(s) copied"
xcopy /f /s /y "precommit.cmd" "%~dp0..\HQ\precommit.cmd*" |find /v "File(s) copied"

for /F "USEBACKQ TOKENS=*" %%b in ("%~dp0_manifest\components.txt") do (

	echo:
	echo Updating collateral files for %%b...
	echo ================================================
	echo:

	REM copy boilerplate THIRD-PARTY-NOTICES.txt if it doesn't exist
	if not exist "%~dp0..\..\HQ\%%b\THIRD-PARTY-NOTICES.txt" copy "%~dp0THIRD-PARTY-NOTICES.txt" "%~dp0..\..\HQ\%%b\THIRD-PARTY-NOTICES.txt" |find /v "File(s) copied"

	REM copy shared settings using project-specific solution name
	xcopy /f /s /y "HQ.X.sln.DotSettings" "%~dp0..\..\HQ\%%b\src\%%b.sln.DotSettings*" |find /v "File(s) copied"
	
	REM copy all manifest files, preserving folder structure
	for /F "USEBACKQ TOKENS=*" %%a in ("%~dp0_manifest\files.txt") do (
		xcopy /f /s /y %%a "%~dp0..\%%b\%%a*" |find /v "File(s) copied"
    )
)
echo:
echo Done.
echo:
