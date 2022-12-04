SETLOCAL
  SET DEV_INSTALLED_PATH=".\dcs\DCS_World_OpenBeta\"
  SET DEV_SAVEDGAME_PATH=".\dcs\Saved_Games\DCS.openbeta\"

  SET DCS_INSTALLED_PATH="F:\DCS World OpenBeta\"
  SET DCS_SAVEDGAME_PATH="C:\Users\blklo\Saved Games\DCS.openbeta\"

  IF NOT EXIST %DCS_SAVEDGAME_PATH%"Scripts\Hooks\" (
    MKDIR %DCS_SAVEDGAME_PATH%"Scripts\Hooks"
  ) ELSE (
    DEL /S /Q %DCS_SAVEDGAME_PATH%"Scripts\Hooks\*"
  )

  IF NOT EXIST %DCS_SAVEDGAME_PATH%"Scripts\Aurora\" (
    MKDIR %DCS_SAVEDGAME_PATH%"Scripts\Aurora"
  ) ELSE (
    DEL /S /Q %DCS_SAVEDGAME_PATH%"Scripts\Aurora\*"
  )

  IF NOT EXIST %DCS_INSTALLED_PATH%"Scripts\AuroraMiz\" (
    MKDIR %DCS_INSTALLED_PATH%"Scripts\AuroraMiz"
  ) ELSE (
    DEL /S /Q %DCS_INSTALLED_PATH%"Scripts\AuroraMiz\*"
  )

  COPY /Y %DEV_SAVEDGAME_PATH%"Scripts\Hooks\*" %DCS_SAVEDGAME_PATH%"Scripts\Hooks\"
  COPY /Y %DEV_SAVEDGAME_PATH%"Scripts\Aurora\*" %DCS_SAVEDGAME_PATH%"Scripts\Aurora\"
  COPY /Y %DEV_INSTALLED_PATH%"Scripts\*" %DCS_INSTALLED_PATH%"Scripts\"
  COPY /Y %DEV_INSTALLED_PATH%"Scripts\AuroraMiz\*" %DCS_INSTALLED_PATH%"Scripts\AuroraMiz\"
ENDLOCAL

CLS

@ECHO DISPATCH COMPLETE