# Ansible Collection - centralesupelec.mydocker

Collection with roles and playbooks to get [MyDocker](https://github.com/CentraleSupelec/mydocker) up and running

## Variables

```yaml
enable_datadog: False
enable_ceph: False
```

## Usage

### Before

- If you want to use NFS for the persisted storage, configure it on the server :
```shell
sudo mkdir -p /mnt/mydocker-fs
sudo mount -t nfs ip.of.the.server:/path/to/mydocker-fs /mnt/mydocker-fs
```

- Make sure that there is a DNS pointing to your server.
- Generate public and private RSA key pair
```shell
openssl genrsa -traditional -out private_key.pem 4096
openssl rsa -traditional -pubout -in private_key.pem -out public_key.pem
```

### Using the playbooks

- Create an inventory with the groups `web`, `docker_swarm_manager`, `docker_swarm_worker` :
```ini
# inventories/myenv/hosts
web_server ansible_host=ip.of.the.server ansible_user=ubuntu

[web]
web_server

[docker_swarm_manager]
web_server

[docker_swarm_worker]
web_server
```
- Create a file with the variables (of course, change those unsafe values, and store them safely, for instance with [ansible-vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html))
```yaml
# inventories/myenv/group_vars/all/variables.yml
back_version: 2.25.0
front_version: 2.24.1
docker_api_version: 2.16.0
web_pg_password: password
web_jwt_secret: secret
web_url: mydocker.mydomain.com
web_letsencrypt_email: myname@mydomain.com
web_back_private_key: |
  -----BEGIN RSA PRIVATE KEY-----
  ...
web_back_public_key: |
  -----BEGIN PUBLIC KEY-----
  ...
```
- Run the playbook :
```shell
ansible-playbook -i inventories/myenv/hosts centralesupelec.mydocker.full_setup
```

[//]: # (Todo: create the repository for the template)

### Make the first user an admin

1. First, visit the new website https://mydocker.mydomain.com (directly or through Moodle) to create your account in the DB
2. Then, connect to the server (SSH) and run following SQL command:
```shell
sudo -u postgres psql thuv -c "UPDATE users_roles SET role_id = (SELECT id FROM roles WHERE name = 'ROLE_ADMIN') WHERE user_id = 1;"
```


## Feature : build image

Requirements :
* A docker registry with credentials to push and pull set in variables 
* A docker image containing those credentials based on [Kaniko](https://github.com/GoogleContainerTools/kaniko) (see below to generate such image)

Corresponding required variables :
* `registry_address`
* `registry_username`
* `registry_password`
* `build_image`
* `build_image_repository` (namespace where built images will be pushed)

## Feature : manually deploying nodes using MyDocker

[//]: # (Todo: create the repository for building the deploy image)
Requirements :
* A docker image built using the dedicated repository
* A terraform state stored on a S3 storage

Corresponding required variables :
* `deploy_image`
* `s3_backend_access_key`
* `s3_backend_secret_key`
* `ovh_consumer_key`
* `ovh_application_secret`
* `os_username`
* `os_password`
* `smtp_username`
* `smtp_password`
* `smtp_server`
* `smtp_port`
* `smtp_from`
* `smtp_to`
* `terraform_state_url`

## Feature : automatically deploying nodes using MyDocker

Requirements :

[//]: # (Todo: provide a more secure way to retrieve the state)
* A docker image built using the dedicated repository
* A terraform state stored on a S3 storage


Corresponding required variables :
* `deploy_image`
* `autoscaling_state_base_url`
* `s3_backend_access_key`
* `s3_backend_secret_key`
* `ovh_consumer_key`
* `ovh_application_secret`
* `os_username`
* `os_password`
* `smtp_username`
* `smtp_password`
* `smtp_server`
* `smtp_port`
* `smtp_from`
* `smtp_to`
* `terraform_state_url`

## Feature : Ceph storage

Requirements :
* A Ceph RBD & CephFS cluster on OVH

Corresponding required variables :
* `enable_ceph`
* `ceph_user`
* `ceph_pool`
* `ceph_key`
* `ceph_service_name` : OVH service name to create ACL

## How To : generate an image based on Kaniko with credentials to build and push new images

