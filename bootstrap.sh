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
