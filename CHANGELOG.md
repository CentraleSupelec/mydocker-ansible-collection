# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
this project does NOT adhere to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

## 0.23.0
### Added
- Added app name variable
- Added magic link expiration variable

## 0.22.0
### Added
- Add custom labels to nodes

## 0.21.0
### Added
- Add informations list to config.js template and default value

## 0.20.0
### Fixed
- Use swarm node id instead of hostname to select the target in a docker_swarm_init task

## 0.19.0
### Changed
- Set caddy server deployment mode to global and remove node selection based on role

## 0.18.0
### Added
- Redirection to documentation URL ([!25](https://github.com/CentraleSupelec/mydocker-ansible-collection/pull/25))

### Fixed
- Fix sudo on ssh key provisioning and remove ssh key provisioning from `swarm` playbook ([!23](https://github.com/CentraleSupelec/mydocker-ansible-collection/pull/23))

## 0.17.0
### Fixed
- Changed caddy to caddy_server in hosts template

## 0.16.0
### Changed
- Deploy caddy servers only on nodes with caddy_server label

## 0.15.0
### Changed
- Use caddy in ditributed mode (controller + servers)
- Add variable `cephfs_plugin` to allow setting the plugin URL
- Add 502 to `test_connection_error_codes` variable
- Avoid warnings in assert statement by changing `{{ item }}` to `vars[item]` 

## 0.14.0
### Changed
- use fully qualified names for roles and activate Datadog only if enable_datadog is set to true

## 0.13.0
### Changed
- Allow to upload files up to 3GB

## 0.12.0
### Changed
- Add Aristote Dispatcher reverse proxy from inside containers in the swarm
- Add variable for Websocket connections close delay

## 0.11.0
### Fixed
- Fix dd-java-agent URL

## 0.10.0
### Changed
- Add config for OIDC (`oidc_audience` / `oidc_issuer` / `oidc_idps` / `oidc_scope` / `auto_login`)
- Add config for custom logo and favicon. Put them in a `files/` directory next to your `inventory/` dir and set `logo_filename`/`favicon/filename` to `"{{ inventory_dir }}/../../files/myfile.png"`
- Allow empty `cas_base_url` to disable CAS login

### Fixed
- Fix if services exist in mode replicated-job or global-job

## 0.9.0
### Changed
- Add labels to caddy to fallback to status 410
- Add new `app.testConnectionScheduler.*` back-end settings

## 0.8.0
### Changed
- Add variable `docker_swarm_volume_upgrade` to allow plugin upgrade
### Fixed
- Fix caddy var in template

## 0.7.0
### Changed
- Upgrade Docker python SDK

## 0.6.0
### Changed
- Add variables for SSL wildcard certificates and reverse proxy main URL
- Add variable for default storage backend

## 0.5.0
### Changed
- Add timeout on post apt update dpkg-lock test

## 0.4.0
### Fixed
- Remove manual nvidia patch on `post_docker` as it is run on boot with udev rule and trigger a docker restart.

## 0.3.0
### Fixed
- Do not output server without ipv4 in generated inventory

## 0.2.0
### Fixed
- Fix for new output of openstack.cloud.server_info module
- Fix wrong handler name
### Changed
- Untaint servers in build state

## 0.1.0
Initial version
