" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

set background=light

set macligatures
set guifont=Fira\ Code:h12

" Local config
if filereadable($HOME . "/.gvimrc.local")
  source ~/.gvimrc.local
endif
