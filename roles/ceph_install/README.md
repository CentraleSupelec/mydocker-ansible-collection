# Ceph-install

This role should be provisioned on every swarm nodes using Ceph.

* install Ceph client and credentials

## Requirements

* None

## Role Variables

* (required) `ceph_user` : will be prepended with `client.`
* (required) `ceph_key`
* (required) `ceph_ips` : list of 3 ips of the Ceph cluster
* `enable_ceph` : configure ceph auth (default: `False`)

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: docker
  roles:
     - centralesupelec.mydocker.ceph-install
```
