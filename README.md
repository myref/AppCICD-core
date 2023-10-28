# AppCICD
Basic setup for getting applications installed on bare infra.

We are working on a way to automagically install application environments with Terraform from the CICD Toolbox and this repo contains the first files...

## How to get going
* az login (arrange for your Azure subscription yourself) or have Cisco CML installed and reachable with the account: Developer/C1sco12345
* terraform init
* Azure:
* * terraform apply --auto-approve -var-file=MyApplication_Mycustomer_Azure.tfvars.json
 
* CML:
  * terraform apply --auto-approve -var-file=MyApplication_Mycustomer_CML.tfvars.json
