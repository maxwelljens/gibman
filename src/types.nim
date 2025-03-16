# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page
import yaml/annotations

type ShellCmd* = object
  engine*: string
  args*: seq[string]

type ConfigEngineEntry* = object
  name*: string
  path*: string

type ConfigIWadEntry* = object
  name*: string
  path*: string

type ConfigPresetEntry* = object
  name*: string
  description* {.defaultVal: "".}: string
  engine*: string
  iwad*: string
  wad* {.defaultVal: @[].}: seq[string]
  args* {.defaultVal: @[].}: seq[string]

type Config* = object
  iwad*: seq[ConfigIWadEntry]
  engine*: seq[ConfigEngineEntry]
  search* {.defaultVal: @[].}: seq[string]
  preset* {.defaultVal: @[].}: seq[ConfigPresetEntry]
