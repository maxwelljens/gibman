# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] 2025-03-08

### Added

- Configuration based on a YAML file, located in
`$XDG_CONFIG_HOME/gibman/gibman.yaml`, or `~/.config/gibman/gibman.yaml` if
`$XDG_CONFIG_HOME` is not set.
- `-p/--preset` option to run presets.
- `-l/--list-presets` option to list presets that are specified in the
`gibman.yaml` file.
