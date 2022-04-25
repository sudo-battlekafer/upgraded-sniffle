## Create Ubuntu 20.04-3 template in ESXi/VCenter/VMware 6.5/6.7/7

# Prerequisites
- iso binary mastering program (options: xorriso, mkisofs, hdiutil, or oscdimg)
- mkpasswd (package whois)
- packer 1.6+ (https://learn.hashicorp.com/tutorials/packer/get-started-install-cli)

To install prerequsites on Ubuntu:
```sh
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer mkisofs whois
```


# Steps

1. update variables.json or variables.pkvars.kcl with your information (either/or, no need for both).
2. update variables-secrets.json with your information.
3. create encrypted password for user-data as described [here](#password_encryption)
4. run the build.sh script (or run the below [commands](#commands) )
- If you are NOT running this inside WSL2, please comment out the powershell.exe lines in build.sh to avoid usless commands/errors.  

# password_encryption

If PASSWORD is missing then it is asked interactively.

Example password creation:

```sh
mkpasswd -m sha-512 --rounds=4096
Password: ubuntu
```

Gets you

```sh
Password:
$6$rounds=4096$pHezCCe7G$voWu63hapkR129fkGSWyYhz6YS113nNQjFNO/OFrJaGdcMd2esa3jHhaaW1ZDwSG6A2Iu2q2XEGN/.cZJcDYH0
```

Put the result into http/user-data, line 21

# Commands

Running build.sh will set the environment variables for logging, PACKER_LOG=1 and PACKER_LOG_FILE="packerlogs.txt", run a `packer init`, then run the `packer build` command with the hcl files.  

This can also be run mannually, shown below.  Both hcl and json work

**Running packer build with hcl**

```sh
packer build -force -on-error=ask -var-file variables.pkrvars.hcl -var-file vsphere.pkrvars.hcl ubuntu-20.04.pkr.hcl
```

**Running packer build with json**

```sh
packer build -force -on-error=ask -var-file variables.json -var-file variables-secrets.json ubuntu-20.04.json
```

# Troubleshooting

- If packer gets stuck on `Waiting for IP` you may want to check your DHCP server. I ran out of leases from running packer so many times. I had to flush inactive DHCP clients.

# Credits

Most work was already done by many people, but 99% of my work originally came from Sam Gabrail via his [blog](https://tekanaid.com/posts/hashiCorp-packer-for-vmware-ubuntu-templates-and-terraform-for-building-vms) and his YouTube video [here](https://www.youtube.com/watch?v=4yb-iofeqeY).  Their source code is at the [gitlab link](https://gitlab.com/public-projects3/infrastructure-vmware-public/vmware-packer-ubuntu20-04-public)
