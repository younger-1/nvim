<https://github.com/junegunn/vim-easy-align>

<https://devhints.io/vim-easyalign>

Usage:
- <CR> to cycle between alignment mode (left, right, or center)
- N-th delimiter (default: 1)
    `1`  Around the 1st occurrences of delimiters
    `2`  Around the 2nd occurrences of delimiters
    `*`  Around all occurrences of delimiters
    `**` Left-right alternating alignment around all delimiters
    `-`  Around the last occurrences of delimiters (-1)
    `-2` Around the second to last occurrences of delimiters
- Delimiter key (a single keystroke; <Space>, =, :, ., |, &, #, ,) or an arbitrary regular expression followed by <CTRL-X>

Alignment options:
| Option             | Type    | Default               | Description                                             |
| ------------------ | ------- | --------------------- | ------------------------------------------------------- |
| `filter`           | string  |                       | Line filtering expression: `g/../` or `v/../`           |
| `left_margin`      | number  | 1                     | Number of spaces to attach before delimiter             |
| `left_margin`      | string  | `' '`                 | String to attach before delimiter                       |
| `right_margin`     | number  | 1                     | Number of spaces to attach after delimiter              |
| `right_margin`     | string  | `' '`                 | String to attach after delimiter                        |
| `stick_to_left`    | boolean | 0                     | Whether to position delimiter on the left-side          |
| `ignore_groups`    | list    | ['String', 'Comment'] | Delimiters in these syntax highlight groups are ignored |
| `ignore_unmatched` | boolean | 1                     | Whether to ignore lines without matching delimiter      |
| `indentation`      | string  | `k`                   | Indentation method (*k*eep, *d*eep, *s*hallow, *n*one)  |
| `delimiter_align`  | string  | `r`                   | Determines how to align delimiters of different lengths |
| `align`            | string  | `l`                   | Alignment modes for multiple occurrences of delimiters  |

Shortcuts for alignment options
| Key       | Option             | Values                                             |
| --------- | ------------------ | -------------------------------------------------- |
| `CTRL-F`  | `filter`           | Input string (`[gv]/.*/?`)                         |
| `CTRL-I`  | `indentation`      | shallow, deep, none, keep                          |
| `CTRL-L`  | `left_margin`      | Input number or string                             |
| `CTRL-R`  | `right_margin`     | Input number or string                             |
| `CTRL-D`  | `delimiter_align`  | left, center, right                                |
| `CTRL-U`  | `ignore_unmatched` | 0, 1                                               |
| `CTRL-G`  | `ignore_groups`    | `[]`, `['String']`, `['Comment']`                  |
| `CTRL-A`  | `align`            | Input string (`/[lrc]+\*{0,2}/`)                   |
| `<Left>`  | `stick_to_left`    | `{ 'stick_to_left': 1, 'left_margin': 0 }`         |
| `<Right>` | `stick_to_left`    | `{ 'stick_to_left': 0, 'left_margin': 1 }`         |
| `<Down>`  | `*_margin`         | `{ 'left_margin': 0, 'right_margin': 0 }`          |

1. predefined rule of =

```
// Origin
Lorem=ipsum
dolor  =sit
amet+=  consectetur==  adipiscing
elit-= set  !=do
eiusmod= tempor=  incididunt
ut &&= labore

// ga=
// = Around the 1st occurrences
Lorem     = ipsum
dolor     = sit
amet     += consectetur==  adipiscing
elit     -= set  !=do
eiusmod   = tempor=  incididunt
ut      &&= labore

// ga2=
// 2= Around the 2nd occurrences
Lorem=ipsum
dolor  =sit
amet+=  consectetur == adipiscing
elit-= set          != do
eiusmod= tempor      = incididunt
ut &&= labore

// ga*=
// *= Around all occurrences
Lorem     = ipsum
dolor     = sit
amet     += consectetur == adipiscing
elit     -= set         != do
eiusmod   = tempor       = incididunt
ut      &&= labore

// ga**=
// **= Left/Right alternating alignment around all occurrences
Lorem     =       ipsum
dolor     =         sit
amet     += consectetur == adipiscing
elit     -=         set != do
eiusmod   =      tempor  = incididunt
ut      &&=      labore

// ga<CR>*=
// <CR>: Right-alignment around all occurrences
  Lorem   =       ipsum
  dolor   =         sit
   amet  += consectetur == adipiscing
   elit  -=         set !=         do
eiusmod   =      tempor  = incididunt
     ut &&=      labore

// ga<CR><CR>*=
// <CR><CR>: Center-alignment around all occurrences
 Lorem    =    ipsum
 dolor    =     sit
 amet    += consectetur == adipiscing
 elit    -=     set     !=     do
eiusmod   =   tempor     = incididunt
  ut    &&=   labore
```

2. predefined rule of <space>

```
// Origin
Paul McCartney 1942
George Harrison 1943
Ringo Starr 1940
Pete Best 1941

// ga<space>
Paul   McCartney 1942
George Harrison 1943
Ringo  Starr 1940
Pete   Best 1941

// ga2<space>
Paul McCartney  1942
George Harrison 1943
Ringo Starr     1940
Pete Best       1941

// ga-<space>
// -: Around the last occurrences
Paul McCartney  1942
George Harrison 1943
Ringo Starr     1940
Pete Best       1941

// ga<CR><CR>2<space>
// Center-alignment around the 2nd occurrences
Paul  McCartney 1942
George Harrison 1943
Ringo   Starr   1940
Pete     Best   1941
```
