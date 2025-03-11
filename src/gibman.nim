# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

import cligen, config, osproc, utils

const Version = """
gibman 1.0.1
Program written by Maxwell Jensen (c) 2025
Licensed under European Union Public Licence 1.2.
For more information, consult README.md"""

proc argParser(list_presets = false, preset = "", verbose = false, version = false) =
  if version:
    echo Version
    return

  let config = parseConfig(preset)
  let shellCmd = constructShellCmd(config, preset)

  if list_presets:
    echoPresetTable(config.preset)
    return
  if verbose:
    shellCmd.echoShellCmd()

  let process = startProcess(shellCmd.engine, "", shellCmd.args)
  process.close()

dispatch argParser,
  cmdName="gibman",
  doc="A DOOM WAD manager for nerds",
  help={
  "help": "Print this information",
  "help-syntax": "Program interface details",
  "list-presets": "List presets defined in configuration file",
  "preset": "Specify preset to run DOOM with",
  "verbose": "Run program in verbose mode",
  "version": "Print version information"}
