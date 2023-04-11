# ad-demo-env-aws

This repo is meant to give you a way to test AD/LDAP functionality with Vault.

The result of this is a new EC2 instance that runs as a stand-alone domain controller, a new HCP Vault cluster, and a functioning connection between the two.
You can use the Terraform provider for AD to add new security groups and users, and then map those to Vault.  You can also use the Vault LDAP secrets engine against this domain controller.

This is a two-step process to set this up, as we have to bootstrap the domain controller using user_data, so we have to wait for a full reboot and initialization before we can do anything else.

-----

Process 1: build infr

a. clone this repo

b. set up a TFC workspace with /AWS as the root.  

c. create an HCP service principal and set the credentials as env vars in thw workspace (HCP_CLIENT_ID & HCP_CLIENT_SECRET)

d. set the AWS creds as environmental vars in this workspace (use doormat)

e. create a new keypair (ssh-keygen -t rsa), set the windows_public_key and windows_private_key variable values.

f. run it, this will give you a public IP for the domain controller.


-----

Process 2: Add AD objects and connect to Vault

a. Once the AD controller is INITIALIZED, create another workspace and set the root to /AD

b. Log into the AWS console to get the Windows password (doormat aws --role <role> console).  Go to EC2 Instances > Connect > RDP client > Get password > upload your private key and decrypt the password.  Set this as the windows_password variable in the workspace.
  
c. set the ad_controller_public_ip variable in the workspace.
  
d. Set the VAULT_TOKEN, VAULT_NAMESPACE, and VAULT_ADDR variables in the workspace.  Get this from HCP.
e. run it
