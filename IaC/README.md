# Infrastructure as a Code
Here is all infrastructure for this Project.

All resources are created with **Terraform** and configured with **Ansible**.

Infrastructure in Terraform was made with composable, sharable and reusable [`modules`](https://github.com/serhiiKalchenko/terraform.git).

There are 2 options:
1. `infra-default`
    - infrastructure with default network
2. `infra-network`
    - infrastructure with own network: VPC, subnet, gateway, route table, etc. 

## How to use it
1. `git clone` repo
2. Configure credentials (`aws.zip`) for accessing AWS (see below)
3. Configure Ansible and dynamic inventory plugin:
    - `./install_roles_plugin.sh`
4. Run command (script):
    - `./make-all.sh`

### Credentials
In any `ansible` role (`./roles/ansible/files`) should be the file with AWS credentials:
- `aws.zip` 

<details>
<summary> Explanations: </summary>
Here is used the concept of shared credentials file.

Archive folder `.aws` from your home dir and put the file `aws.zip` into any `ansible` role you use (`./roles/ansible/files`).

Ansible role `ansible` take this credentials file and copy it in `jenkins` user home dir:
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
