# Package

version       = "1.0.0"
author        = "Maxwell Jensen"
description   = "A CLI DOOM WAD manager for nerds"
license       = "EPL-2.0"
srcDir        = "src"
bin           = @["gibman"]


# Dependencies

requires "nim >= 2.2.2"
requires "cligen"
requires "nancy"
requires "rainbow"
requires "yaml"
