# Steps to Publish

## In VS Code

Run the command
```sh
dotnet publish -o publish --configuration release
```

Go to the folder
Remove:
Microsoft.CodeAnalysis.*
Microsoft.VisualStudio.*
NuGet.*

## Download PuTTy

- [Putty.org](https://www.putty.org/)


## Generate SSH Key using PuttyGen

- Key comment should be your username
- On Windows, save the Private Key file to C:\
= Add public SSH key to the VM keys


## Debian .NET Commands

- Download Install Package
```sh
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
```

- Register the Downloaded Package
```sh
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```

- Install runtime
```sh
sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-6.0
```

- Verify 
```sh
dotnet --info
```

- Create Project Folder
```sh
mkdir catalog
cd catalog
pwd
```

- *copy the folder path*


## Copy files from local computer to the VM using SCP

*From the VS Code terminal*:
```sh
cd publish
pscp -r -i c:\catalog-ssh.ppk * {USERNAME}@{IP_ADDRESS}:/home/{USERNAME}/catalog
```

## Set Production Environment Variable and run the app
===================================================
*In PuTTy:*:

```sh
export ASPNETCORE_ENVIRONMENT=Production
dotnet catalog.dll
```
-  Change firewall rule to open the 8080 port 

## Startup Script
==============
```sh
#!/bin/bash
export ASPNETCORE_ENVIRONMENT=Production 
cd /home/{USERNAME}/catalog
dotnet catalog.dll
```

- Setup Startup  Script

![Startup Script Setup](image.png)

```sh
sh /home/vijay_k_vepakomma/Start.sh
```

- View Logs
![Startup Logs](StartupLogs.png)