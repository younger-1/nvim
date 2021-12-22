
                                           *lightspeed-disable-default-mappings*
Lightspeed does not remap any keys for which there is a custom mapping already
defined. If you wish to preserve the _native_ behaviour of some of the keys,
for example f/F/t/T, simply unmap the given keys after the plugin has been
loaded (either `noremap f f` or `silent! unmap f`, for each), or equivalently,
map anything unused to the corresponding <Plug> keys, before the plugin has
been loaded.
