@echo off
setlocal
rem get datetime of script execution
rem then format datetime string to yyyymmddhhmmssfff
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set dt_fmt=%dt:~0,14%%dt:~15,3%

rem define variables
set source_path=%1
set target_path=%2
set archive_path=%3
set tmp_get_cmd_file=\path\to\tmp_get_cmd_%dt_fmt%.txt
set tmp_put_cmd_file=\path\to\tmp_put_cmd_%dt_fmt%.txt
set log_filename=sample_%dt_fmt%.log

rem create tmp_get_cmd_file, which retrieves then deletes the source files
rem for newer versions of scp, -del option is available for get operation
rem for older versions, tmp_get_cmd_file also creates a temp folder to avoid new files with same naming patterns from being deleted 
rem old version: echo mkdir %source_path%/../%dt_fmt% > %tmp_get_cmd_file%
rem old version: echo mv %source_path% %source_path%/../%dt_fmt%/ >> %tmp_get_cmd_file%
rem old version: echo get -o %source_path%/../%dt_fmt%/* %target_path% >> %tmp_get_cmd_file%
rem old version: echo del -s %source_path%/../%dt_fmt% >> %tmp_get_cmd_file%
echo open sftp://myuser:mypassword@myhost.com/ -hostkey="ssh-rsa 2048 xxxxxxxxxxx...=" > %tmp_get_cmd_file%
echo get -o -delete %source_path%/../%dt_fmt%/* %target_path% >> %tmp_get_cmd_file%
echo exit >> %tmp_get_cmd_file%

rem create tmp_put_cmd_file, which copies the source path to target path
echo open sftp://myuser:mypassword@myhost.com/ -hostkey="ssh-rsa 2048 xxxxxxxxxxx...=" > %tmp_put_cmd_file%
echo put -o %source_path% %target_path% > %tmp_put_cmd_file%
echo exit >> %tmp_put_cmd_file%

rem execute the get transfer
winscp /script=%tmp_get_cmd_file% /log=%log_filename%
rem execute the put transfer
winscp /script=%tmp_put_cmd_file% /log=%log_filename%
rem catch error
if %ERRORLEVEL% neq 0 goto HandleError

rem for put transfer, archive locally
move %source_path% %archive_path%

rem clean up tmp cmd files
del %tmp_get_cmd_file%
del %tmp_put_cmd_file%

endlocal
exit /B 0


rem function to handle errors
:HandleError
@echo "sftp failed, please check logs"
powershell -command \path\to\sample-send-email.ps1
exit /B %ERRORLEVEL%


REM function to call if renaming needed when archiving
:RenameArchive
setlocal EnableDelayedExpansion
for %%b in (%source_path%) do (
	for %%c in (%%b) do (
		set new_filename=Archive_%%~nxc
	)
	ren "%%b" "!new_filename!"
	move "%%b\..\!new_filename!" "%archive_path%"
)
endlocal
