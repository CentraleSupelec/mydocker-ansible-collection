# Docker-swarm-manager

This role should be provisioned on the every docker swarm node.

* disable workload scheduling on the manager
* add seccomp profile if `docker_swarm_seccomp_override` is set to `true`

## Requirements

None.

## Role Variables

* (default `2377`) `docker_swarm_port`: the port for the advertise address of the swarm
* (default `false`) `docker_swarm_seccomp_override`: whether to override seccomp configuration
* (default value specified in `vars/main.yml`) `docker_swarm_seccomp_folder`: folder on which to store seccomp configuration

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: docker_swarm

  roles:
     - docker-swarm
```
