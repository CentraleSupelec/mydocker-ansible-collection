# Docker-api

This role should be provisioned on the Docker Swarm manager to install the `docker-api` server (= operate as a gateway to the Docker API).


## Requirements

* None

## Role Variables
* `scale_up_interval` (default `10s`)
* `golang_log_level` (default `error`)
* `scale_up_cooldown` (default `5m`)
* `scale_down_interval` (default `5m`)
* `scale_down_remove_non_empty` (default `false`)
* `admin_image` : used only for the feature o
* `precreate_volume`
* `docker_api_version`
* `web_docker_api_location`
* `authenticated_registries` : array of dicts with keys `address` / `username` / `password`; default :
```yaml
  - address: "{{ registry_address }}"
    username: "{{ registry_username }}"
    password: "{{ registry_password }}"
```
* `registry_address`: address of the main registry to pull images from
* `registry_username`: username of the main registry to pull images from
* `registry_password`: password of the main registry to pull images from
* `build_image`
* `env`
* `build_image_repository`
* `ceph_user`
* `ceph_pool`
* `ceph_service_name`
* `deploy_image`
* `smtp_username` : used for emails in case of deployment error
* `smtp_password`
* `smtp_server`
* `smtp_port`
* `smtp_from`
* `smtp_to`
* `s3_backend_access_key`
* `s3_backend_secret_key`
* `ovh_consumer_key`
* `ovh_application_secret`
* `os_username`
* `os_password`
* `autoscaling_state_base_url`

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: docker
  roles:
     - centralesupelec.mydocker.ceph-install
```
