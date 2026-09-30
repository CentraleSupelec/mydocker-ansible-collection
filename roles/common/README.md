# Common

This role should be provisioned on every VM.

* install basic utilities
* install oh-my-zsh, add the oh-my-via theme and
  a custom .zshrc
* sets up ssh authorized keys for users

## Requirements

* the local machine must have rsync installed

## Role Variables

* (default value specified in `vars/main.yml`) `common_local_tmp_folder`: local folder used to store temporary files
* (optional) `common_users`: users for which to change the shell and add screen configuration (user must already exist)
* (optional) `common_ssh_authorized_keys`: the authorized keys to set for each user (user must already exist).
Example :
```yaml
common_ssh_authorized_keys:
  debian:
    - ssh-rsa ...
    - ssh-rsa ...
  root:
    - ssh-rsa ...
```

## Docker upgrades are deferred

Docker and containerd packages still upgrade with the rest of the host, but the
upgrade never restarts them, so running containers survive. This covers
`apt upgrade`, unattended-upgrades and `needrestart`. The role installs
`/usr/sbin/policy-rc.d` (denies docker and containerd service actions) and a
`/etc/needrestart/conf.d/docker.conf` drop-in (non-interactive, skips docker,
containerd and thuv-docker). Both stay in place permanently.

A pending upgrade takes effect at the next host reboot, or by running
`systemctl restart docker` in a maintenance window.

If a `/usr/sbin/policy-rc.d` not written by this role already exists, the run
fails instead of overwriting it.

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: all

  roles:
     - centralesupelec.mydocker.common
```
