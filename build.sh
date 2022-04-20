#!/usr/bin/env bash
export PACKER_LOG=1
export PACKER_LOG_PATH="packerlogs.txt"

<<<<<<< HEAD
echo ">Forwarding port from Windows to WSL2"
powershell.exe 'netsh interface portproxy add v4tov4 listenport=4000 listenaddress=0.0.0.0 connectport=4000 connectaddress=127.0.0.1'

echo ">Packer Init!"
=======
echo ">Initializing Packer!"
>>>>>>> 1edabccba7c405fb7a937499386bf3430896b8bb
packer init ubuntu-20.04.pkr.hcl

echo ">Let's get building!"
packer build -force -on-error=ask -var-file variables.pkrvars.hcl -var-file vsphere.pkrvars.hcl ubuntu-20.04.pkr.hcl

<<<<<<< HEAD
echo ">Deleting port forward for security"
powershell.exe 'netsh interface portproxy delete v4tov4 listenport=4000 listenaddress=0.0.0.0 connectport=4000 connectaddress=127.0.0.1'
=======
>>>>>>> 1edabccba7c405fb7a937499386bf3430896b8bb
