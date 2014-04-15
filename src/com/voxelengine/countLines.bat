REM =====================

echo off

cls

REM set variables

set ASDir=C:\dev\VoxelVerse\src\com\voxelengine

REM run the program

REM See docs for different output formats.

cloc-1.60.exe --by-file-by-lang --force-lang="ActionScript",as --report-file=totalLOC.txt %ASDir% 

REM show the output

totalLOC.txt

REM end

pause

REM =====================