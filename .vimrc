""
"" Basic Setup
""

set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set numberwidth=5     " Add some padding before numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

if exists("g:enable_mvim_shift_arrow")
  let macvim_hig_shift_movement = 1 " mvim shift-arrow-keys
endif

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen

""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter

""
"" Wild settings
""

" TODO: Investigate the precise meaning of these settings
" set wildmode=list:longest,list:full

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swap files
""

set backupdir^=~/.vim/_backup//    " where to put backup files.
set directory^=~/.vim/_temp//      " where to put swap files.

""
"" NERDTree settings
""

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <C-r> :NERDTreeToggle<CR>
map <leader>n :NERDTreeToggle<cr> 

let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']
let NERDTreeQuitOnOpen = 0
let NERDTreeShowHidden = 0

let g:loaded_netrw        = 1 " Disable netrw
let g:loaded_netrwPlugin  = 1 " Disable netrw

""
"" ZoomWin settings
""

map <leader>zw :ZoomWin<cr> 

""
"" Everything else
""

" Interpret numerals with leading zeros as decimals rather than octals
set nrformats=

" Auto indent
filetype indent on

" Theme settings
colorscheme DesertEx
set gfn=Anonymous_Pro:h14

" Disable backups
set nobackup
set nowritebackup
set noswapfile

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile Appraisals,Gemfile set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell

" Automatically wrap at 80 characters for Markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Relative line numbers
"http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

:au FocusLost * :set number           " GUI only
:au FocusGained * :set relativenumber " GUI only

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Execute the current buffer
:map <Leader>e :!%<cr>

" rails.vim mappings
map ,m :Rmodel 
map ,sm :RSmodel 
map ,vm :RVmodel 
map ,tm :RTmodel 
map ,c :Rcontroller 
map ,sc :RScontroller 
map ,vc :RVcontroller 
map ,tc :RTcontroller 
map ,v :Rview 
map ,sv :RSview 
map ,vv :RVview 
map ,tv :RTview 
map ,s :RSpec 
map ,ss :RSSpec 
map ,vs :RVSpec 
map ,ts :RTSpec 
map ,e :Rextract 
map ,r :Rails 
map ,g :Rgenerate 
map ,t :Rtask 
map ,st :RStask 
map ,vt :RVtask 
map ,tt :RTtask 

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

""
"" Pathogen
""

execute pathogen#infect()