# Shortletapp

This repo contains:
- Current Time API located at `currentTimeAPI` folder
- Terraform code located at `GKE_IAC` folder
- Helm Chart located at `helm-chart` folder
- Policy Script found at `policy/policy.rego`

## Getting started

Clone the project and `cd` into the `GKE_IAC` to run terraform commands.

```
git clone https://github.com/emmygozi/shortletapp.git
cd GKE_IAC
```

Get a json credential file and project ID from GCP [here](https://developers.google.com/workspace/guides/create-credentials). 

## Authentication

Get authenticated via the Command Line Interface `cli`. First install [gcloud](https://cloud.google.com/sdk/docs/install), Google's CLI.

Then [get authenticated](https://cloud.google.com/docs/authentication/gcloud). 


## Installation

Technologies and tools used

- [ ] [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- [ ] [nodejs](https://nodejs.org/en/download/package-manager)

- [ ] [kubernetes](https://kubernetes.io/releases/download/)

- [ ] [helm](https://helm.sh/docs/intro/install/)

- [ ] [conftest](https://www.conftest.dev/install/)

- [ ] [docker](https://www.docker.com/)


## Local Installation

Install `Docker` as shown above

Install `Terraform` as shown above


## Terraform Configurations
The terraform code contains:

- A module that deploys GKE - Node pools, auto scaler, nodes and    workloads

- A firewall that allows inbound traffic on ports `22`, `443` and `80`

- State file saved on GCP bucket

- Network configurations for VPC, subnets and cidr blocks

- GCP Roles for pulling GCR registry

- Terraform helm deployment


## Create Infrastructure and Deploy Helm Chart

To create infrastructure on gcp using terraform

```
cd GKE_IAC
terraform init
terraform init -upgrade
terraform validate
terraform plan
terraform apply -auto-approve
```
`terraform init -upgrade` Upgrade all previously-selected plugins to the newest version that complies with the configuration's version constraints


## Test and Deploy

Follow previous steps to install `Conftest` then run

```
cd GKE_IAC
terraform init
terraform plan -no-color -out=tfplan
terraform show -json tfplan > tfplan.json
cd ..
conftest test GKE_IAC/tfplan.json 
```

## Project Status and Possible Improvements

The following ways has been identified as areas where the cluster can be further improved in a production facing cluster:

- Using a private kubernetes cluster and creating a bastion host for security

- Creation of more policy as code tests

- RBAC in the GKE cluster

- Improved due diligence in cidr block IP allocation, VPC and subnet security

- Creation of reusuable terraform scripts and use of tools like `Terragrunt`, terraform orchestration tool and `Terraformer` a CLI tool that generates tf/json and tfstate files based on existing infrastructure (reverse Terraform).


