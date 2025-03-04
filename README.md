# gibman

![](logo.png)

*A GZDoom WAD manager for nerds*

## Quick usage:

Given the following configuration in `$XDG_CONFIG/gibman/gibman.yaml`:

```yaml
engine: /home/media/Development/gzdoom/build/gzdoom

iwad:
  - name: doom2
    path: /.../DOOM2.WAD

wad:
  - name: eviternity
    path: /.../Eviternity.wad

preset:
  - name: example
    iwad: doom2
    wad:
      - eviternity
```

Run the following to run your `example` preset:

```fish
gibman -p example
```

This will run GZDoom with the DOOM 2 IWAD and Eviternity WAD.
