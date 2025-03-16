# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

import streams, os, types, yaml, utils, unicode

const DefaultConfig = readFile("default_config.yaml")

proc loadEngine(
    shellCmd: ref ShellCmd, config: Config, specificPreset: ConfigPresetEntry
) =
  for x in config.engine:
    if x.name == specificPreset.engine:
      shellCmd.engine = x.path
      return
  throwError("No engine '" & specificPreset.engine & "' has been found.")

proc loadIWad(
    shellCmd: ref ShellCmd, config: Config, specificPreset: ConfigPresetEntry
) =
  for x in config.iwad:
    if x.name == specificPreset.iwad:
      shellCmd.args.add(["-iwad", x.path])
      return
  throwError("No IWAD '" & specificPreset.iwad & "' has been found.")

proc loadWads(
    shellCmd: ref ShellCmd, config: Config, specificPreset: ConfigPresetEntry
) =
  for wad in specificPreset.wad:
    var entryFound = false
    for searchPath in config.search:
      try:
        for file in walkDir(searchPath, checkDir = true):
          let splitFile = file.path.splitFile()
          if splitFile.name.toLower() == wad.toLower() and
              splitFile.ext.toLower() in [".wad", ".pk3", ".zip"]:
            shellCmd.args.add(["-file", file.path])
            entryFound = true
      except OSError as e:
        throwError("Specified path to search does not exist (" & e.msg & ")")
    if not entryFound:
      echoWarn(
        "WAD '" & wad & "' from preset '" & specificPreset.name &
          "' not found in search list."
      )
    entryFound = false

proc loadAdditionalArgs(
    shellCmd: ref ShellCmd, config: Config, specificPreset: ConfigPresetEntry
) =
  for x in specificPreset.args:
    shellCmd.args.add(x)

proc loadPreset(shellCmd: ref ShellCmd, config: Config, presetName: string) =
  for x in config.preset:
    if x.name == presetName:
      shellCmd.loadEngine(config, x)
      shellCmd.loadIWad(config, x)
      shellCmd.loadWads(config, x)
      shellCmd.loadAdditionalArgs(config, x)
      return
  throwError("No preset with given name '" & presetName & "' has been found.")

proc createDefaultConfig() =
  let configFilePath = getConfigDir() / "gibman" / "gibman.yaml"
  if fileExists(configFilePath):
    throwError("File already exists.")
  try:
    createDir(getConfigDir() / "gibman")
    writeFile(configFilePath, DefaultConfig)
    echo(
      "No configuration file was found. Created configuration file at " & configFilePath &
        ". It contains all available information to help you ",
      "get started with your gibman use.",
    )
    quit(0)
  except IOError as e:
    throwError(
      "Unable to place default configuration file at " & configFilePath & ": " & e.msg &
        ". Permission error?"
    )

proc parseConfig*(preset: string): Config =
  var config: Config
  var foundConfig = false
  for file in walkDir(getConfigDir() / "gibman"):
    let splitFile = file.path.splitFile()
    if file.kind == pcFile and splitFile.name == "gibman":
      foundConfig = true
      var s = newFileStream(file.path)
      load(s, config)
      s.close()
  if not foundConfig:
    createDefaultConfig()
  return config

proc constructShellCmd*(config: Config, preset: string): ref ShellCmd =
  var shellCmd = new(ShellCmd)
  if preset != "":
    shellCmd.loadPreset(config, preset)
  else:
    shellCmd.engine = config.engine[0].path
    shellCmd.args.add(["-iwad", config.iwad[0].path])
  return shellCmd
