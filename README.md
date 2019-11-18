# Amazon Linux AMI
To install Jupyterhub on EC2 instance follow these steps:
1. Lunch EC2 instance:
    a. In Step 1: Choose an Amazon Machine Image (AMI), we choose Amazon Linux AMI * as AMI.
    b. In Step 2: Choose an Instance Type, choose the instance specs
    c. In Step 3: Configure Instance Details after configure all options at Advanced Details/User data input these scripts:

```bash
#!/bin/bash

## Linux packages
yum update -y
yum install -y gcc-c++ make tmux
## Node.js
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
yum install -y nodejs

## Anaconda & jupyterhub
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -P /tmp
bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda3/
echo 'export PATH=/opt/anaconda3/bin:$PATH' >> /etc/bashrc
/opt/anaconda3/bin/conda install anaconda -y
/opt/anaconda3/bin/pip install jupyterhub
mkdir /etc/jupyterhub



## Setting up node.js proxy
npm install -g configurable-http-proxy



## SSL Certification
openssl genrsa 2048 > /etc/jupyterhub/host.key
openssl req -new -x509 -nodes -sha256 -days 365 -key /etc/jupyterhub/host.key -out /etc/jupyterhub/host.cert



## Jupyterhub configuration
echo '''
# Configuration file for jupyterhub.

#------------------------------------------------------------------------------
# JupyterHub(Application) configuration
#------------------------------------------------------------------------------

## An Application for starting a Multi-User Jupyter Notebook server.


## Grant admin users permission to access single-user servers.
c.JupyterHub.admin_users = {'admin.username'}
c.LocalAuthenticator.create_system_users = True"
## Path to SSL certificate file for the public facing interface of the proxy
#
# When setting this, you should also set ssl_key
c.JupyterHub.ssl_cert = '/etc/jupyterhub/host.cert'

## Path to SSL key file for the public facing interface of the proxy
#
# When setting this, you should also set ssl_cert
c.JupyterHub.ssl_key = '/etc/jupyterhub/host.key'
'''> /etc/jupyterhub/jupyterhub_config.py
```

3. Now we can ssh to instance, and after 15 minutes all should be installed properly. Run this script on shell to start a jupyterhub in tmux screen, and we can detach from screen with ctrl+b+d:

```shell
~# sudo tmux new -s jupyterhub
[tmux:jupyterhub]~$ jupyterhub -f /etc/jupyterhub/jupyterhub_config.py --port 443
```
