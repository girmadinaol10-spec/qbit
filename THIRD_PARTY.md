# Third-party components

Qbit Linux includes the components below. Each keeps its own licence and copyright.
The author and licence columns are read from the components' own metadata; a dash means
the component does not state it.

| Type | Name | Author | Licence | Website | Note |
|---|---|---|---|---|---|
| Global themes | Vivid-Dark-Global-6 | l4k1 | GPLv3 | https://github.com/L4ki/Vivid-Plasma-Themes |  |
| Plasma styles | Vivid-Dark-Plasma | l4k1 | GPL-3.0+ | https://github.com/L4ki/Vivid-Plasma-Themes |  |
| Window decorations | Vivid-Blur-Dark-Aurorae-6 | l4k1 | GPLv3 | - |  |
| Window decorations | Vivid-Dark-Aurorae-6 | l4k1 | GPLv3 | - |  |
| Icon themes | Vivid-Dark-Icons | - | - | - | UNKNOWN - verify before publishing |
| Icon themes | Vivid-Glassy-Dark-Icons | - | - | - | UNKNOWN - verify before publishing |
| Colour schemes | VividCyanDarkColorscheme | - | - | - | UNKNOWN - verify before publishing |
| Colour schemes | VividStrongCyanDarkColorscheme | - | - | - | UNKNOWN - verify before publishing |

## Debian packages

The packages named in `config/package-lists/` are installed from Debian's repositories during the
build. Each keeps its own licence, found in `/usr/share/doc/<package>/copyright` inside the image.
This includes the Hack font (package `fonts-hack`) used by the default terminal profile.
