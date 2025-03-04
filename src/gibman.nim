# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

import cligen, streams, os, osproc, yaml
include configinit

const Version = """
gibman 0.1.0
Program written by Maxwell Jensen (c) 2025
Licensed under European Union Public Licence 1.2.
For more information, consult README.md or man page"""

proc argParser(arguments: seq[string] = @[], preset = "", version = false) =
  if version:
    echo Version
    return

  let parsedConfig = parseConfig(preset)
  let process = startProcess(parsedConfig.engine, "", parsedConfig.args)
  while process.running():
    stdout.write(process.peekableOutputStream().readChar())
  process.close()

dispatch argParser,
  cmdName="gibman",
  doc="A WAD manager for GZDoom",
  help={
  "help": "Print this information",
  "help-syntax": "Program interface details",
  "arguments": "Pass additional arguments to GZDoom",
  "preset": "Specify preset to run DOOM with",
  "version": "Print version information"}
