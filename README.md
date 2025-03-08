# gibman

![](logo.png)

*A DOOM WAD manager for nerds*

## What is `gibman`?

`gibman` is a simple CLI utility designed to do one thing: to run presets for
your favourite DOOM engine. Although chiefly designed with GZDoom in mind,
other engines should be supported (more on that below). The program operates on
a simple [YAML](https://www.redhat.com/en/blog/yaml-beginners) file, with which
you can set up all of your engines, IWADs, and WADs. Both Windows and Linux are
supported.

## Quick usage:

Given the following configuration in `$XDG_CONFIG_HOME/gibman/gibman.yaml`, or
`~/.config/gibman/gibman.yaml` if `$XDG_CONFIG_HOME` is not set:

```yaml
engine:
  - name: gzdoom
    path: /path/to/gzdoom

iwad:
  - name: doom2
    path: /path/to/DOOM2.WAD

wad:
  - name: eviternity
    path: /path/to/Eviternity.wad

preset:
  - name: example
    description: A description to help you remember what the preset is for
    engine: gzdoom
    iwad: doom2
    wad:
      - eviternity
    args: []
```

Run the following to run your `example` preset:

```fish
gibman -p example
```

This will run GZDoom with the DOOM 2 IWAD and Eviternity WAD. More information
can be found in `default_config.yaml`, which is also placed in
`$XDG_CONFIG_HOME/gibman/gibman.yaml` when running the program for the first
time.

## How does `gibman` work?

At its core, the program simply constructs a string to execute as command in
the user's shell. This makes the program both platform-agnostic and not tied to
any particular DOOM engine. The above example would produce the following
string:

```fish
/path/to/gzdoom -iwad /.../DOOM2.WAD -file /.../Eviternity.wad
```

If you were to specify any `args` in your preset, those would be added at the
end. For example:

```yaml
args:
  - -dog
  - 2
```

Would be added to the above command at the end as `-dog 2`, which is a command
line option in the Woof! DOOM engine. This allows you to use any DOOM engine
that uses the `-iwad` and `-file` command line options. Such engines include
GZDoom, ZDoom, Woof!, Eternity Engine, and probably many others.

## Options

The program includes a few options. Running the program without any options
simply executes the default (i.e. topmost specified) engine and IWAD in the
`gibman.yaml` configuration file.

- **`-h/--help`**: Print help for the program.

- **`-p/--preset`**: Execute the specified preset. The `name` attribute is used
as the argument for this option.

- **`-l/--list-presets`**: List the presets in your configuration. This is
helpful if you forget which presets you have, but don't want to open a text
editor to read the `gibman.yaml` file again. It looks like the following:

```
┌─────────┬───────────────────────────────────────┬────────┬───────────────────┐
│ Name    │ Description                           │ Engine │ WADs              │
├─────────┼───────────────────────────────────────┼────────┼───────────────────┤
│ example │ A description to help you remember    │ gzdoom │ doom2, eviternity │
│         │ what the preset is for                │        │                   │
└─────────┴───────────────────────────────────────┴────────┴───────────────────┘
```

- **`-v/--verbose`**: Run program in verbose mode. At the moment this only
means printing the shell string before launching the game.

## Installing

### Windows and Linux

Binary releases (executables) of `gibman` are available for both Windows and
Linux in the [Releases page](https://github.com/maxwelljens/gibman/releases).

### macOS

Due to difficulty in cross-compiling for macOS, binary releases for macOS are
not available. macOS users need to compile from source.

## Compiling from source

`gibman` is made in the [Nim](https://nim-lang.org/) programming language, so
the Nim toolchain will be required. This can be acquired
[here](https://nim-lang.org/install.html), and it is the recommended method for
all platforms. This will install both Nim and the Nimble package manager, both
of which are required for compiling `gibman` from source.

Afterwards, navigate to the root of the project and run the following command
to compile `gibman`:

```fish
nimble c -o:build/gibman src/gibman.nim
```

If all goes well, this should download all dependencies and produce an
executable of `gibman` in the `build` directory for your platform.

## Licence

This software is licensed under the [European Union Public Licence
1.2](https://eupl.eu/1.2/en/). 2025 copyright of Maxwell Jensen.
