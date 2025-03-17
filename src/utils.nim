# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

import std/envvars, rainbow, nancy, types, strutils

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
  if existsEnv("NO_COLOR"):
    table.add "Name", "Description", "Engine", "WADs"
  else:
    table.add "Name".rfYellow,
      "Description".rfYellow, "Engine".rfYellow, "WADs".rfYellow
  for x in presets:
    if existsEnv("NO_COLOR"):
      wads = wads & x.iwad & ", "
    else:
      wads = wads & x.iwad.rfGreen & ", "
    for s in x.wad:
      wads = wads & s & ", "
    wads.removeSuffix(", ")
    table.add x.name, x.description, x.engine, wads
    wads = ""
  table.echoTableSeps(80, boxSeps)

proc echoShellCmd*(shellCmd: ShellCmd) =
  var str: string
  if existsEnv("NO_COLOR"):
    str = str & shellCmd.engine & " "
    for x in shellCmd.args:
      str = str & x & " "
  else:
    str = str & shellCmd.engine.rfYellow & " "
    for x in shellCmd.args:
      if x.len > 0 and x[0] == '-':
        str = str & x.rfGreen & " "
      else:
        str = str & x & " "
  echo(str)
