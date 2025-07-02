# CS-Demo-AWS

## Intro

This is a multi-module project to install Proxy Clusters with a bridged worker into a private AWS network, with one of each resources

At this time the project is only for AWS and you will need your AWS Access Keys:

## Customize the Deployment

Please open the `config.tf` file and fill out the following items:

- [ ] **name**: This is the project name and will be a prefix for most resources deployed in AWS and SDM.
- [ ] **tags**: These are the tags you want put on all of your resources in AWS and especially SDM
- [ ] **aws_region**: This is required for deployment and will be the region that everything is deployed in.
- [ ] **existing_users**: This is a list of existing user emails that you would like to have workflow access to these resources.
     > [!NOTE]
     > The email addresses MUST be present in your StrongDM tenant already or the plan/apply will fail. 
- [ ] **Resources**: Select True or False for whichever resources you would like to deploy.

  **Resources available:**

  - SSH and simple web server
  - RDP Windows server
  - RDS MySQL database
  - EKS Cluster (run the setup yaml to get discovery and privilege levels)

> [!WARNING]
> These scripts create infrastructure resources in your AWS account, incurring AWS costs. Once you are done testing, remove these resources to prevent unnecessary AWS costs. You can remove resources manually or with `terraform destroy`. StrongDM provides these scripts as is, and does not accept liability for any alterations to AWS assets or any AWS costs incurred.

---

## To Run the Module

1. Clone the repository:

   ```shell
   git clone https://github.com/berretterry/cs-pc-aws-demo.git
   ```

2. Switch to the directory containing the cloned project:

   ```shell
   cd cs-pc-aws-demo
   ```

3. Set environment variables for the API key

   ```shell
   # strongdm access and secret keys
   export SDM_API_ACCESS_KEY=auth-xxxxxxxxxxxx
   export SDM_API_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

   # For the AWS creds, ideally set your profile.
   export AWS_PROFILE=<profile-name>

   # Otherwise, set your keys
   # export AWS_ACCESS_KEY_ID=xxxxxxxxx
   # export AWS_SECRET_ACCESS_KEY=xxxxxxxxx
   ```

4. Initialize the working directory containing the Terraform configuration files:

   ```shell
   terraform init
   ```

5. Execute the actions proposed in the Terraform plan:

   ```shell
   terraform apply
   ```

> [!NOTE]
> The script runs until it is complete. Note any errors. If there are no errors, you should see new resources, such as databases, clusters, or servers, in the StrongDM Admin UI. Additionally, your AWS Management Console displays any new resources added when you ran the module.

6. Remove the resources created with Terraform Destroy:

   ```shell
   terraform destroy
   ```

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

```shell
chmod +x setup-sdm-rbac.sh
```

Then you can run the script normally and it will update the cluster

```shell
./setup-sdm-rbac.sh
```
