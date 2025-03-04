# Program written by Maxwell Jensen (c) 2025
# Licensed under European Union Public Licence 1.2.
# For more information, consult README.md or man page

const ConfigFile = getConfigDir() / "gibman" / "gibman.yaml"

type ProcessDetails = object
  engine : string
  args : seq[string]

type IWadSubconf = object
  name : string
  path : string

type WadSubconfEntry = object
  name : string
  path : string

type PresetSubconfEntry = object
  name : string
  iwad : string
  wad : seq[string]

type Config = object
  iwad : seq[IWadSubconf]
  engine : string
  wad : seq[WadSubconfEntry]
  preset : seq[PresetSubconfEntry]

proc loadIWad(config: Config, processDetails: ref ProcessDetails, specificPreset: PresetSubconfEntry) =
  for x in config.iwad:
    if x.name == specificPreset.iwad:
      processDetails.args.add(["-iwad", x.path])

proc loadWads(config: Config, processDetails: ref ProcessDetails, specificPreset: PresetSubconfEntry) =
  for x in specificPreset.wad:
    for y in config.wad:
      if x == y.name:
        processDetails.args.add(["-file", y.path])

proc loadPreset(config: Config, processDetails: ref ProcessDetails, preset: string) =
  for x in config.preset:
    if x.name == preset:
      processDetails.engine = config.engine
      loadIWad(config, processDetails, x)
      loadWads(config, processDetails, x)
      return
  echo("No preset with given name '", preset, "' has been found.")
  quit(1)

proc parseConfig(preset: string): ref ProcessDetails =
  var config: Config
  var processDetails = new(ProcessDetails)
  var s = newFileStream(ConfigFile)
  load(s, config)
  s.close()

  if preset != "":
    loadPreset(config, processDetails, preset)
  else:
    processDetails.engine = config.engine
    processDetails.args.add(["-iwad", config.iwad[0].path])

  return processDetails
