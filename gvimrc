" CommandT OS-X Menu remapping
if has("gui_macvim")
  macmenu &File.New\ Tab key=<D-S-t>
endif

map <D-t> :CommandT<CR>
