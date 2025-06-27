# CS-Demo-AWS

-

## Intro

This is a multi-module project to install Proxy Clusters with a bridged worker into a private AWS network, with one of each resources

At this time the project is only for AWS and you will need your AWS Access Keys:

`export AWS_ACCESS_KEY_ID=<"ACCESS_KEY">`

`export AWS_SECRET_ACCESS_KEY=<"SECRET_KEY">`

`export AWS_SESSION_TOKEN=<"TOKEN">`

You will also need your StrongDM API Keys to deploy into StrongDM

`export SDM_API_ACCESS_KEY=<"ACCESS_KEY">`

`export SDM_API_SECRET_KEY=<"SECRET_KEY">`

---

## Configuration

Please open the `config.tf` file and fill out the following items:

- [ ] name: This is the project name and will be a prefix for most resources deployed in AWS and SDM.
- [ ] tags: These are the tags you want put on all of your resources in AWS and especially SDM
- [ ] aws_region: This is required for deployment and will be the region that everything is deployed in.
- [ ] existing_users: This is a list of existing user emails that you would like to have workflow access to these resources.
- [ ] Resources: Select True or False for whichever resources you would like to deploy.

  **Resources available:**

  - SSH and simple web server
  - RDP Windows server
  - RDS MySQL database
  - EKS Cluster (run the setup yaml to get discovery and privilege levels)

---

## Infrastructure

### AWS

The following infrastructure is always created in AWS:

- There is a single VPC with 2 public subnets and 2 private subnets.
- 1 NLB is configured to direct traffic from incoming 443 to the Proxy Bridge. This also handles communication between the Proxy Worker and Bridge.
- 1 ECS cluster is created with 2 services and 2 tasks, one for the Proxy Bridge, and one for the Proxy Worker
- Secret's manager is used to store the SDM Secret Key for the Proxy Cluster. This can be refactored in the future to also store other secrets

### StrongDM

The following will be deployed every time into StrongDM

- An admin role with the project name prefix is added to each of the provided email addresses.
- A dynamic access rule is also created with a "workflow" tag that will be associated with access workflows.
- An auto approval workflow and access workflow are created for any of the resources onboarded with this module and the admin role associate with it.
- Every user added to the config file will be able to request access to any resource onboarded with this module.

---

## Configuring the EKS cluster for Discovery and Privilege Escalation

There is a yaml file that has all of the roles and role bindings needed to get things to work called sdm-rbac.yaml

You can run through the steps on your own of connecting to the cluster, or you can run the shell script that is also provided setup-sdm-rbac.sh

If the shell script doesn't run you may have to use a chmod command

`chmod +x setup-sdm-rbac.sh`

Then you can run the script normally and it will update the cluster

`./setup-sdm-rbac.sh`
