# wsl2_move_docker_image.ps1
# Docker 镜像存储位置一键迁移脚本（适用于 WSL2 版本）
#
# Powershell Script 3.0+
# ---------------------------------------------------------------------------------------
# 脚本使用方式（需使用管理员权限执行）:
#   .\wsl2_move_docker_image.ps1 -target "D:\wsl\docker"
# ---------------------------------------------------------------------------------------
#
# target: 期望迁移的目录
param([string]$target="D:\wsl\docker")

Write-Host "Stop docker ..."
net stop "com.docker.service"

Write-Host "Stop wsl ..."
wsl --shutdown

Write-Host "Move docker-desktop-data image ..."
wsl --export docker-desktop-data $target\tmp\docker-desktop-data.tar
wsl --unregister docker-desktop-data
wsl --import docker-desktop-data $target\data\ $target\tmp\docker-desktop-data.tar --version 2
Remove-Item $target\tmp\docker-desktop-data.tar -recurse

Write-Host "Move docker-desktop image ..."
wsl --export docker-desktop $target\tmp\docker-desktop.tar
wsl --unregister docker-desktop
wsl --import docker-desktop $target\distro\ $target\tmp\docker-desktop.tar --version 2
Remove-Item $target\tmp\docker-desktop.tar -recurse

Write-Host "Finish."