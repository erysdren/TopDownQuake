# TopDownQuake

TDQ is a CSQC-only Quake mod allowing you to play the game in a fully top-down view, in the style of classic top-down twin-stick shooters like the NES game Commando.

The code has been entirely rewritten from the ground up, not relying on any code or assets from the old versions of the mod.

The latest release can be downloaded in the releases section, or on [Slipseer](https://www.slipseer.com/index.php?resources/topdownquake.24/).

- Current Release Version: `2.0 (January 22, 2023)`

![A screenshot of Quake, rendered in a top-down view rather than a first-person view.](./.github/fte-20230122051945-0.png)

## Planned Features

- Bring back features from the older versions, like fog-of-war and other settings.
- Add March-April 2022 jam content.
- Add robust controller bindings.
- Add DOOM-Automap style mode.
- Add optional tracers for hitscan weapons.
- Add optional halos for enemies.

## Launching

Before launching, make sure to copy the `id1` folder from your copy of Quake into the `game` folder. After that, you can launch the executable appropriate for your platform.

- Windows: `fteglqw64.exe`
- Linux: `fteqw-sdl2`

## Building

To build the QuakeC code for TopDownQuake, use the `fteqcc64` application (which can be downloaded [here](https://www.fteqcc.org/)) and point it to `/source/tdq.src`. The rest will be taken care of for you.

## License

MIT License

Copyright (c) 2023 erysdren

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
