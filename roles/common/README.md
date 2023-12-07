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

## Dependencies

None.

## Example Playbook

```yaml
---
- hosts: all

  roles:
     - centralesupelec.mydocker.common
```
