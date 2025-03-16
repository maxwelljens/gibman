# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

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
  description*: string
  engine*: string
  iwad*: string
  wad*: seq[string]
  args*: seq[string]

type Config* = object
  iwad*: seq[ConfigIWadEntry]
  engine*: seq[ConfigEngineEntry]
  search*: seq[string]
  preset*: seq[ConfigPresetEntry]
