# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

import std/envvars, rainbow, nancy, types

proc throwError*(s: string, i: int = 1) =
  if existsEnv("NO_COLOR"):
    echo("ERROR: ", s)
  else:
    echo("ERROR: ".rfRed, s)
  quit(i)

proc echoWarn*(s: string) =
  if existsEnv("NO_COLOR"):
    echo("WARNING: ", s)
  else:
    echo("WARNING: ".rfYellow, s)

proc echoPresetTable*(presets: seq[ConfigPresetEntry]) =
  var table: TerminalTable
  var wads: string
  let noColor = existsEnv("NO_COLOR")
  if noColor:
    table.add "Name", "Description", "Engine", "WADs"
  else:
    table.add "Name".rfYellow,
      "Description".rfYellow, "Engine".rfYellow, "WADs".rfYellow
  for x in presets:
    if noColor:
      wads.add x.iwad
    else:
      wads.add x.iwad.rfGreen
    for s in x.wad:
      wads.add ", "
      wads.add s
    table.add x.name, x.description, x.engine, wads
    wads = ""
  table.echoTableSeps(80, boxSeps)

proc echoShellCmd*(shellCmd: ref ShellCmd) =
  var str: string
  if existsEnv("NO_COLOR"):
    str.add shellCmd.engine
    for x in shellCmd.args:
      str.add " "
      str.add x
  else:
    str.add shellCmd.engine.rfYellow
    for x in shellCmd.args:
      str.add " "
      if x.len > 0 and x[0] == '-':
        str.add x.rfGreen
      else:
        str.add x
  echo(str)
