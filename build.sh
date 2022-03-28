#!/usr/bin/env bash
export PACKER_LOG=1
export PACKER_LOG_PATH="packerlogs.txt"

echo ">Initializing Packer!"
packer init ubuntu-20.04.pkr.hcl

echo ">Let's get building!"
packer build -force -on-error=ask -var-file variables.pkrvars.hcl -var-file vsphere.pkrvars.hcl ubuntu-20.04.pkr.hcl

