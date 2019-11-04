# Jupyterhub ON EC2

1. Follow this file steps to setup the EC2 instance:

https://the-littlest-jupyterhub.readthedocs.io/en/latest/install/amazon.html

2. instead of step 7, you can use this script for configuration. Under **Step 3: Configure Instance Details**, scroll to the bottom of the page and toggle the arrow next to Advanced Details. Scroll down to **User data**. Copy the text below, and paste it into the User data text box. Replace <admin-user-name> with the name of the first admin user for this JupyterHub. This admin user can log in after the JupyterHub is set up, and configure it. Remember to add your username!
  
```bash
#!/bin/bash
curl https://raw.githubusercontent.com/smmsadr/jupyterhub-ec2/master/bootstrap.py \
  | sudo python3 - \
    --admin <admin-user-name>
```
