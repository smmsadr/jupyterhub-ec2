# Amazon Linux AMI
To install Jupyterhub on EC2 instance follow these steps, to *Lunch EC2 instance*:

1. In **Step 1: Choose an Amazon Machine Image (AMI)**, we choose Amazon Linux AMI * as AMI.
2. In **Step 2: Choose an Instance Type**, choose the instance specs
3. In **Step 3: Configure Instance Details** after configure all options at **Advanced Details**/**User data** input these scripts:

```
#!/bin/bash
curl https://raw.githubusercontent.com/smmsadr/jupyterhub-ec2/master/bootstrap.sh \
  | sudo bash
```

4. In case, you have validate ssl key and cert, just replace /etc/jupyterhub/host.* with them.

5. Now we can ssh to instance, and after 15 minutes all should be installed properly. Run this script on shell to start a jupyterhub in tmux screen, and we can detach from screen with ctrl+b+d:

```shell
~# sudo tmux new -s jupyterhub
[tmux:jupyterhub]~$ jupyterhub -f /etc/jupyterhub/jupyterhub_config.py --port 443
```
