
                                           *lightspeed-disable-default-mappings*
Lightspeed does not remap any keys for which there is a custom mapping already
defined. If you wish to preserve the _native_ behaviour of some of the keys,
for example f/F/t/T, simply unmap the given keys after the plugin has been
loaded (either `noremap f f` or `silent! unmap f`, for each), or equivalently,
map anything unused to the corresponding <Plug> keys, before the plugin has
been loaded.


2-character search (after invoking the motion)~

<Tab>                      Switch the search direction on the fly.

2-character search (after entering the full pattern)~

<Space>                    Shift to the next group of labeled matches.
<Tab>                      Shift to the previous group of labeled matches.

1-character search~

;                          Repeat the previous f/t motion in the forward
                           direction, or revert `,`. 
,                          Repeat the previous f/t motion in the backward
                           direction, or revert `;`.

