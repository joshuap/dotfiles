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

" Command to delete trailing whitespace
:nnoremap <silent> <Leader>ws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Format the entire file
:nnoremap <Leader>fef mzgg=G`z

" Clipboard (for tmux interaction).
" set clipboard=unnamed

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
"" Load plugins
""

if filereadable(expand("$HOME/.vimrc.plugins"))
  source $HOME/.vimrc.plugins
endif

""
"" NERDTree settings
""

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

map <leader>n :NERDTreeToggle<cr> 

let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']
let NERDTreeQuitOnOpen = 0
let NERDTreeShowHidden = 0

" let NERDTreeHijackNetrw = 0
" let g:loaded_netrw        = 1 " Disable netrw
" let g:loaded_netrwPlugin  = 1 " Disable netrw

""
"" ZoomWin settings
""

map <leader>zw :ZoomWin<cr> 

""
"" Mouse support
""

" Send more characters for redraws.
set ttyfast

" Enable mouse use in all modes.
set mouse=a


" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
if !has('nvim')
  set ttymouse=xterm2
endif

""
"" Theme settings
""

" Fix highlighting for spell checks in terminal
" See https://github.com/chriskempson/base16-vim/issues/182
function! s:base16_customize() abort
  " Colors: https://github.com/chriskempson/base16/blob/master/styling.md
  " Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
  call Base16hi("SpellBad",   "", "", g:base16_cterm08, g:base16_cterm00, "", "")
  call Base16hi("SpellCap",   "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
  call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
  call Base16hi("SpellRare",  "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
endfunction
augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" colorscheme base16-onedark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256  " Access colors present in 256 colorspace
  source ~/.vimrc_background
endif

" color overrides
highlight LineNr ctermbg=NONE guibg=NONE
highlight Comment cterm=italic
hi TabLine ctermbg=black
hi TabLineFill ctermbg=black
hi TabLineSel ctermbg=magenta
hi CursorLine ctermbg=NONE
hi CursorLineNr ctermbg=NONE

""
"" Airline
""
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['%l/%L %c'])
  let g:airline_section_b = airline#section#create(['branch'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:airline_theme='base16_shell'

let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
let g:airline_skip_empty_sections = 1

""
"" deoplete
""

" Enable completion engine
let g:deoplete#enable_at_startup = 1

" Use tab to cycle completion candidates
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use ctrl+j/k to cycle completion candidates
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Insert candidate and close popup
inoremap <expr> <Return> pumvisible() ? deoplete#close_popup() : "\<Return>"

""
"" neosnippet
""

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""
"" Everything else
""

" Interpret numerals with leading zeros as decimals rather than octals
set nrformats=

" Auto indent
filetype indent on

" Disable backups
set nobackup
set nowritebackup
set noswapfile

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" Automatically wrap text in text files
autocmd FileType text set formatoptions+=t

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake,Appraisals set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.json set filetype=javascript

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell

" Automatically wrap at 80 characters for Markdown
autocmd BufRead,BufNewFile *.md setlocal textwidth=80

" Automatically wrap text in Markdown files
autocmd BufRead,BufNewFile *.md set formatoptions+=t

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

" Toggle relative line numbers
nnoremap <silent> <C-n> :set relativenumber!<cr>

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
map <Leader>T :tag 
map <Leader>t :FZF<CR>

" Fugitive mappings
map <Leader>gb :Gblame<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gl :Glog<CR>
map <Leader>gc :Gcommit<CR>
map <Leader>gp :Git push<CR>

" ruby mappings
au Filetype ruby nnoremap <leader>r :!ruby %<CR>

" vim-go mappings
au Filetype go nnoremap <leader>r :GoRun %<CR>
au Filetype go nnoremap <leader>T :GoTest %<CR>
au Filetype go nnoremap <leader>l :GoLint<CR>


" Use goimports instead of gofmt
let g:go_fmt_command = "goimports"

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" vim-markdown
set concealcursor=""

" vim-test
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" neomake
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)

" ale
let g:ale_linters = {'ruby': ['standardrb'], 'javascript': ['eslint']}
let g:ale_fixers = {'ruby': ['standardrb'], 'javascript': ['eslint']}

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_fix_on_save = 1
