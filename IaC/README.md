# Infrastructure as a Code
You can run all objects separately or all together:
- `jenkins-srv`
- `kube-cluster`
- `all-in-one`

## How to use it
1. git clone repo
2. Configure credentials (`aws.zip`) for accessing AWS (see below)
3. Configure Ansible roles and dynamic inventory plugin 
    - run `./install_roles_plugin.sh` in folder you wanna use (`jenkins-srv` or `kube-cluster` or `all-in-one`)
4. Initiate Terraform: 
    - run `terraform init`
6. Run the object you choose
    - `./make-jenkins.sh`
    - `./make-kube.sh`
    - `./make-it-all.sh`

### Credentials
- file `aws.zip` with AWS credentials should be in any `ansible` role (`./roles/ansible/files`)

#### Explanations
Jenkins server use Ansible to deploy app into Kubernetes cluster.

Ansible for that use dynamic inventory. So the user `jenkins` should have `.aws` at his home dir to do that.

Ansible role `ansible` do it all automatically, but it needs to have `aws.zip` file in its folder `files`.

Archive your folder `.aws` from your home dir and put file `aws.zip` into any `ansible` role you use (`./roles/ansible/files`).

To get `.aws` folder use AWS CLI. To configure it, run: `aws configure`

You can choose credentials any user you made in AWS (IAM). 

Permissions (policy): `AmazonEC2ReadOnlyAccess` 
