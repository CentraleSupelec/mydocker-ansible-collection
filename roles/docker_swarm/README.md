# Docker-swarm-manager

This role should be provisioned on the every docker swarm node.

* disable workload scheduling on the manager
* add seccomp profile if `docker_swarm_seccomp_override` is set to `true`

## Requirements

None.

## Role Variables

* (default `2377`) `docker_swarm_port`: the port for the advertise address of the swarm
* (default `false`) `docker_swarm_seccomp_override`: whether to override seccomp configuration
* (default `/opt/docker-seccomp`) `docker_swarm_seccomp_folder`: folder on which to store seccomp configuration
* (default `rbd`) `docker_swarm_volume_backend` : storage backend to use, either `rbd` for Ceph, or `fs` for filesystem
* (default `centralesupelec/mydockervolume:latest`) `docker_swarm_volume_plugin` : volume plugin to use
* `ceph_user`
* `ceph_ips`
* (default `mydocker-{{ env }}`) `ceph_pool`
* `env` : used to name the default Ceph pool
* `registry_address` : used to push built images
* `registry_username` : used to push built images
* `registry_password` : used to push built images
* `gpu_type` : should be defined *only* for a node with a GPU. Can be either `dedicated` or `shared`. Value is used in role `centralesupelec.mydocker.gpu-pre-docker`
* `owner` : should be undefined for standard default Swarm nodes, and should otherwise match a technical identifier of a Compute Type in MyDocker Admin panel.

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: docker_swarm

  roles:
     - docker-swarm
```
