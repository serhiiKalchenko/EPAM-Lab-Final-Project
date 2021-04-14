# Infrastructure as a Code
Here is all infrastructure for this Project.

You can run all objects separately or all together:
- `jenkins-srv`
    - network: default
- `kube-cluster`
    - network: default 
- `all-in-one`
    - network: all network infrastructure (VPC, subnet, gateway, route table) 

## How to use it
1. git clone repo
2. Configure credentials (`aws.zip`) for accessing AWS (see below)
3. Configure Ansible roles and dynamic inventory plugin in folder you wanna use (`jenkins-srv` or `kube-cluster` or `all-in-one`)
    - `./install_roles_plugin.sh` 
4. Initiate Terraform: 
    - `terraform init`
6. Run one of these scripts (the object you chose):
    - `./make-jenkins.sh`
    - `./make-kube.sh`
    - `./make-it-all.sh`

### Credentials
In any `ansible` role (`./roles/ansible/files`) should be the file with AWS credentials:
- `aws.zip` 

<details>
Explanations
<summary>
Jenkins server use Ansible to deploy app into Kubernetes cluster.

Ansible for that use dynamic inventory. So the user `jenkins` should have `.aws` at his home dir to do that.

Ansible role `ansible` do it all automatically:
```
- name: Extract 'aws.zip' to Jenkins home dir
  become: yes
  unarchive:
    src: ../files/aws.zip
    dest: /home/jenkins
  when: not aws_creds.stat.exists
```
but it needs to have `aws.zip` file in its folder `files`.

Archive folder `.aws` from your home dir and put file `aws.zip` into any `ansible` role you use (`./roles/ansible/files`).

To get `.aws` folder use AWS CLI. To configure it, run: `aws configure`

You can choose credentials any user you made in AWS (IAM). 

Permissions (policy): `AmazonEC2ReadOnlyAccess`
</summary>
</details>
### Ansible roles
- `initial`
- `docker`
- `ansible`
- `kubernetes`
