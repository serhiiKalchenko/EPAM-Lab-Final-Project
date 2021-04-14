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
<summary> Explanations: </summary>
Here is used the concept of shared credentials file.
[spring-petclinic](https://github.com/spring-projects/spring-petclinic)    
Archive folder `.aws` from your home dir and put the file `aws.zip` into any `ansible` role you use (`./roles/ansible/files`).
Ansible role `ansible` take this credentials file and copy it in Jenkins home dir:
```
- name: Extract 'aws.zip' to Jenkins home dir
  become: yes
  unarchive:
    src: ../files/aws.zip
    dest: /home/jenkins
  when: not aws_creds.stat.exists
```
Jenkins needs it because it use Ansible with Dynamic inventory (`hosts_aws_ec2.yml`)


More info about AWS credentials here:
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html

You can choose credentials of any user you made in AWS (IAM). 

Permissions (policy): `AmazonEC2ReadOnlyAccess`
</details>

### Ansible roles
- `initial`
- `docker`
- `ansible`
- `kubernetes`
