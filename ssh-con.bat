@ECHO OFF
TITLE SSH Connect

SET private_key=add_private_key_path_here
SET config_file=connections.properties
SET fields=1,2,3
SET separators=[=,;]

ECHO Use below ^<number^> =^> ^<host^> mapping to connect
FOR /F "tokens=%fields% delims=%separators%" %%A IN (%config_file%) DO (
	ECHO %%A =^> %%B as %%C
)
ECHO ===================================================================

:USER_INPUT
SET /P host=Enter Host Number: 

FOR /F "tokens=%fields% delims==%separators%" %%A IN (%config_file%) DO (
	IF %host% == %%A (
		SET host=%%B
		SET user=%%C
		CLS
		GOTO CONNECT_COMMAND
	)
)

ECHO Invalid Input!
GOTO USER_INPUT

:CONNECT_COMMAND
SSH %user%@%host% -i %private_key%

SSH-CON