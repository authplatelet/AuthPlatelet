@echo off
REM build ProjectBuilder first, and copy the executables to the solutions folders

pushd src\ProjectBuilder\ProjectBuilder
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe /p:OutputPath=bin\Release /p:Configuration=Release
popd
copy src\ProjectBuilder\ProjectBuilder\bin\Release\ProjectBuilder.exe tools
copy src\ProjectBuilder\ProjectBuilder\bin\Release\ProjectBuilder.exe src\Examples
copy src\ProjectBuilder\ProjectBuilder\bin\Release\ProjectBuilder.exe src\AuthClassLib

REM build AuthClassLib
pushd src\AuthClassLib
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe AuthClassLib.sln
popd

REM build ABC Example
pushd src\Examples
set "var=%cd%"
pushd ABC
set "vpath=%cd%"
pushd Server_A
set "build_path=%cd%"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\Server_A.csproj /p:SolutionDir="%var%"\
call :editVP
popd
pushd Server_B
set "build_path=%cd%"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\Server_B.csproj /p:SolutionDir="%var%"\
call :editVP
popd
pushd Server_C
set "build_path=%cd%"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\Server_C.csproj /p:SolutionDir="%var%"\
call :editVP
popd
popd

pushd OpenIDLogin
set "vpath=%cd%"
pushd OpenIDExample
set "build_path=%cd%"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\OpenIDExample.csproj /p:SolutionDir="%var%"\
call :editVP
popd
popd

pushd LiveIDLogin
set "vpath=%cd%"
pushd LiveIDExample
set "build_path=%cd%"
REM C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\LiveIDExample.csproj /p:SolutionDir="%var%"\
call :editVP
popd
popd

pushd FacebookGraphAuth
set "vpath=%cd%"
pushd FacebookGraphApiExample
set "build_path=%cd%"
REM C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\FacebookGraphApiExample.csproj /p:SolutionDir="%var%"\
call :editVP
popd
popd

pushd CILServer
set "vpath=%cd%"
pushd CILRepository
set "build_path=%cd%"
REM C:\Windows\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe .\CILRepository.csproj /p:SolutionDir="%var%"\
REM call :editVP
popd
popd




popd


:editVP
for /f ^"usebackq^ eol^=^

^ delims^=^" %%a in ("%build_path%\Web.config") do (
    echo "%%a" | findstr /C:"VProgramPath">nul && (
      echo     ^<add key="VProgramPath" value="%vpath%\VProgram" /^> >> "%build_path%\temp.config"

    ) || (
      echo %%a >> "%build_path%\temp.config"
    )
)

del "%build_path%\Web.config"
move "%build_path%\temp.config" "%build_path%\Web.config"
goto :eof
