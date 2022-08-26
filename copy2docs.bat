@echo off
xcopy "." ".\docs" /Y /exclude:EXCLUDE.txt
xcopy ".\01_Tools_Docsify\" ".\docs\01_Tools_Docsify\" /Y /exclude:EXCLUDE.txt
xcopy ".\_media\" ".\docs\_media\" /Y /exclude:EXCLUDE.txt
pause
:: xcopy . .\docs /Y /exclude:EXCLUDE.txt