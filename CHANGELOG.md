# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
this project does NOT adhere to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased
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
