set nocompatible
call pathogen#infect()

set shell=/bin/bash\ -l
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

"set title
set foldmethod=indent
set foldlevel=30
set gfn=Monaco:h14.00


" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
set formatprg=/opt/local/bin/par " par for better formatting of prose.


" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

"Vertical split then hop to new buffer
:noremap ,v :vsp^M^W^W<cr>
:noremap ,h :split^M^W^W<cr>

" Cursor highlights ***********************************************************
set cursorline
"set cursorcolumn

" Searching *******************************************************************
set hlsearch " highlight search
set incsearch " incremental search, search as you type
set ignorecase " Ignore case when searching
set smartcase " Ignore case when searching lowercase

" Colors / GUI options  *******************************************************

"set t_Co=256 " 256 colors
set background=dark
if has('gui_running')
  set guioptions-=T " remove toolbar.
  set guioptions-=r " remove right toolbars.
  set guioptions-=R
  set guioptions-=l " remove left toolbars.
  set guioptions-=L
  set lines=40
  set transparency=8
endif

" syntax highlighting with a limit to *****************************************
" the number of highlighted columns per line **********************************
syntax on
set synmaxcol=180
colorscheme ir_black

" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high
match LongLineWarning '\%120v.*' " Error format when a line is longer than 120

" Line Wrapping ***************************************************************
set nowrap
set linebreak " Wrap at word

" File Stuff / File types / Autocommands **************************************
filetype plugin indent on " Enable filetype-specific indenting and plugins
if has("autocmd")
  " au FileType html :set filetype=xhtml
  " To show current filetype use: set filetype
  au BufNewFile,BufRead *.jspf set filetype=jsp
  au BufNewFile,BufRead *.json set ft=javascript
  au bufwritepost .vimrc source $MYVIMRC
endif
nmap <leader>v :tabedit $MYVIMRC<CR>



" Inser New Line **************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>

" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize

" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off bell, this could be more annoying, but I'm not sure how

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

