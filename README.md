# Ansible Collection - centralesupelec.mydocker

Collection with roles and playbooks to get [MyDocker](https://github.com/CentraleSupelec/mydocker) up and running

## Variables

```yaml
enable_datadog: false
enable_ceph: false
```

## Usage

### Before

- If you want to use NFS for the persisted storage, let the `docker_swarm` role mount it on the
  swarm hosts (plugin `centralesupelec/mydockervolume` v1.4.0 or later, which reads the ready
  marker). The export must allow the swarm hosts with `rw,no_root_squash`:
```yaml
docker_swarm_volume_backend: fs
docker_swarm_volume_plugin: centralesupelec/mydockervolume:v1.4.0
docker_swarm_volume_fs_nfs_source: ip.of.the.server:/path/to/mydocker-fs
docker_swarm_volume_fs_ready_marker: .mydocker-ready
```
  The role writes the fstab entry (`rw,sync,hard`), starts Docker after remote file systems and
  creates the marker on the export only. When the root was not mounted before the run, it
  restarts Docker so the plugin binds the export: running containers on that node stop. A root
  that is already mounted from the same export is adopted without a restart. The run stops
  instead of guessing when the root is mounted from another source, when the local directory
  under it holds data, when the plugin serves something other than the export, or when an
  already installed plugin is not armed with the marker (re-run with
  `-e docker_swarm_volume_force_enable_timeout=true` in a maintenance window).
- A node that boots while NFS is unreachable still starts Docker, and the plugin refuses volumes.
  Once NFS is back: `sudo mount /mnt/mydocker-fs && sudo systemctl restart docker` on that node,
  or re-run the play with `--tags docker_install_plugin`.

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
back_version: 2.26.0
front_version: 2.24.2
docker_api_version: 2.16.1
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

Corresponding required variables :
* `registry_address`
* `registry_username`
* `registry_password`
* `build_image_repository` (namespace where built images will be pushed)
* `build_image` (defaults to `docker.io/centralesupelec/kaniko`; must be a Kaniko debug image with a mechanism authorizing to push to `registry_address`)

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


