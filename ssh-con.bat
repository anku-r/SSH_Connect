@echo off
title SSH Connect

set private_key=~/.ssh/ankur_pk
set config_file=connections.properties
set fields=1,2,3
set separators=[=,;]

echo Use below ^<number^> =^> ^<host^> mapping to connect
for /F "tokens=%fields% delims=%separators%" %%A in (%config_file%) do (
	echo %%A =^> %%B as %%C
)
echo ===================================================================

:USER_INPUT
set /P host=Enter Host Number: 

for /F "tokens=%fields% delims==%separators%" %%A in (%config_file%) do (
	if %host% == %%A (
		set host=%%B
		set user=%%C
		cls
		goto CONNECT_COMMAND
	)
)

echo Invalid Input!
goto USER_INPUT

:CONNECT_COMMAND
ssh %user%@%host% -i %private_key%

ssh-con