# Infrastructure as a Code
For convinience (you can run all objects separately) consists of 3 folder:
- `jenkins-srv`
- `kube-cluster`
- `all-in-one`

## How to use
1. git clone repo
2. Configure Ansible roles and dynamic inventory plugin 
    - run `./install_roles_plugin.sh` in folder you wanna use (`jenkins-srv`, `kube-cluster`, `all-in-one`)
3. Initiate Terraform: `terraform init`
4. Run the object you choose
    - `./make-jenkins.sh`
    - `./make-kube.sh`
    - `./make-it-all.sh`

## Credentials
For role `ansible` you need to have `aws.zip` file in `files/` folder.

`aws.zip` is just zip archive of `~/.aws` folder, that any user get when configure CLI access to AWS. You can run just command: `aws configure`

That's require ansible (dynamic inventory) on Jenkins server. It access your EC2 account and get all running EC2 instances.
