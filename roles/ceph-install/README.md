# Ceph-install

This role should be provisioned on every swarm nodes.

* install Ceph client and credentials

## Requirements

* None

## Role Variables

* (required) `vault_ceph_user`, `vault_ceph_key`,`vault_ceph1_ip`, `vault_ceph1_ip`, `vault_ceph1_ip` in `group_vars/ceph/vault.yml`

Example :
```yaml
vault_ceph_user: !vault |
    ...
```

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: docker

  roles:
     - docker-swarm/ceph-install
```