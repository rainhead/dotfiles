" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Leader
let mapleader = " "

set nofoldenable
set smartcase
set ignorecase
set scrolloff=3
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" rainhead
" set title

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.pl set filetype=prolog

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized8_low


" GitHub diff viewer window is 118 characters wide
set textwidth=116
" Make it obvious where text will wrap
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=0
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" vroom
let g:vroom_map_keys = 0
let g:vroom_clear_screen = 0
let g:vroom_use_vimux = 1
let g:vroom_write_all = 1
let g:vroom_use_zeus = 1
let g:vroom_use_bundle_exec = 0
let g:vroom_use_dispatch = 0


map <leader>t :VroomRunTestFile<cr>
map <leader>T :VroomRunNearestTest<cr>
map <leader>/ :Copen!<cr>
autocmd BufNewFile,BufRead *_spec.coffee map <buffer> <leader>t :w<cr>:!zeus teaspoon %<cr>
autocmd BufNewFile,BufRead *_spec.js map <buffer> <leader>t :w<cr>:!zeus teaspoon %<cr>

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

let g:javascript_plugin_flow = 1
let g:ruby_indent_assignment_style = 'variable'
let g:syntastic_rust_checkers = ['rustc']


map <leader>t :VroomRunTestFile<cr>
map <leader>T :VroomRunNearestTest<cr>
map <leader>/ :Copen!<cr>
autocmd BufNewFile,BufRead *_spec.coffee map <buffer> <leader>t :w<cr>:!zeus teaspoon %<cr>
autocmd BufNewFile,BufRead *_spec.js map <buffer> <leader>t :w<cr>:!zeus teaspoon %<cr>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
