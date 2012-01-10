set nocompatible
call pathogen#infect()

set shell=/opt/local/bin/bash\ -l
runtime! macros/matchit.vim

let mapleader = "\\"

" Tabstops ********************************************************************
set ts=2 sts=2 sw=2 expandtab

command! -nargs=* Stab call Stab()

function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>

set foldmethod=indent
set foldlevel=30

command! -nargs=* SmallScreen call FontSize(12)
command! -nargs=* BigScreen call FontSize(14)

function! FontSize(size)
  let &gfn = "DejaVu Sans Mono:h" . a:size
endfunction

" this is for stuff that should happen only once.
if !exists("vimrc_loaded")
  let vimrc_loaded = 1
  set lines=24 columns=80
  set gfn=DejaVu\ Sans\ Mono:h14.00
  set linespace=1
endif

" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
set formatprg=/opt/local/bin/par " par for better formatting of prose.



" Windows *********************************************************************
"set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

"Vertical split then hop to new buffer
:noremap ,v :vsp^M^W^W<cr>
:noremap ,h :split^M^W^W<cr>

" Cursor highlights ***********************************************************
set cursorline
set scrolloff=2
"set cursorcolumn

" Searching *******************************************************************
set hlsearch   " highlight search
set incsearch  " incremental search, search as you type
set ignorecase " ignore case when searching
set smartcase  " ignore case when searching lowercase
nmap <leader>h :noh<CR>

" Colors / GUI options  *******************************************************
if has('gui_running')
  set guioptions-=T " remove toolbar.
  set guioptions-=r " remove right toolbars.
  set guioptions-=R
  set guioptions-=l " remove left toolbars.
  set guioptions-=L
  set transparency=0
  set background=light
else
  set background=dark
endif
colorscheme solarized
" solarized options, these were mentioned to be useful with vims that
" were compiled with support for 256 colors.
" let g:solarized_termcolors = 256
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"


" Syntax highlighting *********************************************************
syntax on
set synmaxcol=320 " limit syntax-highlighted columns for long lines
let g:syntastic_enable_signs=1
" Enable status line indicator
" set statusline+=%{SyntasticStatuslineFlag()}
if has('gui_running')
  sign define SyntasticError text=╳ texthl=error
  sign define SyntasticWarning text=→ texthl=todo
endif


" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high
"match LongLineWarning '\%120v.*' " Error format when a line is longer than 120

" Line Wrapping ***************************************************************
set nowrap
set linebreak " Wrap at word

" File Stuff / File types / Autocommands **************************************
filetype plugin indent on " Enable filetype-specific indenting and plugins
if has("autocmd")
  aug vimrc
    au!
    " To show current filetype use: set filetype
    au BufNewFile,BufRead config.ru,Gemfile,*.api.rsb set filetype=ruby
    au BufNewFile,BufRead *.jspf set filetype=jsp
    au BufNewFile,BufRead *.json set ft=javascript
    au bufwritepost .vimrc,vimrc source $MYVIMRC
    " strip trailing white space on all lines
    autocmd vimrc BufWritePre * :call Preserve("%s/\\s\\+$//e")
    " au FileType html :set filetype=xhtml
  aug END
endif

" Time Savers *****************************************************************

nmap <leader>v :tabedit $MYVIMRC<CR>
cmap w!! w !sudo tee % >/dev/null
nnoremap ; :
map <S-Enter> O<ESC>
map <Enter> o<ESC>


" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" Misc ************************************************************************

set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off bell

" Invisible characters ********************************************************
set listchars=trail:·,tab:▸\ ,eol:¬
set nolist
nmap <leader>l :set list!<CR>

" Unbind the cursor keys in insert, normal and visual modes.
" for prefix in ['i', 'n', 'v']
"   for key in ['<Up>', '<Down>', '<Left>', '<Right>']
"     exe prefix . "noremap " . key . " <Nop>"
"   endfor
" endfor

