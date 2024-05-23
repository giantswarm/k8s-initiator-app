# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Documentation of features migration towards CAPA

## [0.9.8] - 2024-04-18

## [0.9.7] - 2023-11-27

### Fixed

- Fix Policy Exception.

## [0.9.6] - 2023-11-07

### Added

- Policy Exception that enables PSS transition

### Changed

- Replace condition for PSP CR installation.

## [0.9.5] - 2022-09-07

- Make `hostIPC` and `hostPID` in the daemonset configurable

## [0.9.4] - 2022-09-07

- Include NTP example

## [0.9.3] - 2022-06-09

## [0.9.2] - 2021-02-04

- Added link to README under `sources:` to render README in Web UI
- Support user specifying `tolerations`
- Add `hostNetwork` and default to `true`
- Add support for customer RBAC rules
- Add examples of usage

## [0.9.1] - 2020-10-19

- Update app metadata

## [0.9.0] - 2020-10-01

### Added

- Mount /etc/kubernetes/policies/

## [0.8.0] - 2020-09-15

### Added

- Support Affinity rules

## [0.7.0] - 2020-09-15

### Added

- Default network policy.

### Changed

- Update alpine to `3.12.0`.

## [0.6.0] - 2020-09-03


[Unreleased]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.8...HEAD
[0.9.8]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.7...v0.9.8
[0.9.7]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.6...v0.9.7
[0.9.6]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.5...v0.9.6
[0.9.5]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.4...v0.9.5
[0.9.4]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.3...v0.9.4
[0.9.3]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.9.0...v0.9.3
[0.9.0]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/giantswarm/k8s-initiator-app/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/giantswarm/release-operator/releases/tag/v0.6.0
