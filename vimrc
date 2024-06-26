set nocompatible

" Prefer zsh
let zsh_path = trim(system('which zsh'))
if !empty(zsh_path)
  let &shell = zsh_path
endif
" runtime! macros/matchit.vim

let mapleader = "\\"

" Colors / GUI options  *******************************************************
if has('gui_running')
  set guioptions-=T " remove toolbar.
  set guioptions-=r " remove right toolbars.
  set guioptions-=R
  set guioptions-=l " remove left toolbars.
  set guioptions-=L
  set transparency=0
  " grow to maximum horizontal width on entering fullscreen mode
  set fuopt+=maxhorz
else
endif

" set background=dark
" set background=light
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" colorscheme solarized
colorscheme smyck

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

command! -nargs=* TinyFont call FontSize(10)
command! -nargs=* SmallFont call FontSize(12)
command! -nargs=* NormalFont call FontSize(14)
command! -nargs=* BigFont call FontSize(16)
command! -nargs=* LargeFont call FontSize(22)
command! -nargs=* HugeFont call FontSize(36)

function! FontSize(size)
  let &gfn = "Source Code Pro for Powerline:h" . a:size
  set linespace=0
endfunction

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" this is for stuff that should happen only once.
if !exists("vimrc_loaded")
  set nocompatible   " Disable vi-compatibility
  set encoding=utf-8 " Necessary to show unicode glyphs

  let vimrc_loaded = 1
  "set lines=24 columns=80
  call FontSize(14)

  " source powerline.
  " python3 from powerline.vim import setup as powerline_setup
  " python3 powerline_setup()
  " python3 del powerline_setup
  " set laststatus=2   " Always show the statusline

  let NERDTreeShowHidden=1
endif

" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent (local to buffer)
set formatprg=par " par for better formatting of prose.

" Windows *********************************************************************
"set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright

"Vertical split then hop to new buffer
:noremap ,v :vsp^M^W^W<cr>
:noremap ,h :split^M^W^W<cr>

" Cursor highlights ***********************************************************
set scrolloff=2
set sidescroll=1
" set cursorline " became too slow.
"set cursorcolumn

" Searching *******************************************************************
set hlsearch   " highlight search
set incsearch  " incremental search, search as you type
set ignorecase " ignore case when searching
set smartcase  " ignore case when searching lowercase
nmap <leader>h :noh<CR>

" respect gitignore in ctrlp (https://github.com/kien/ctrlp.vim/issues/174)
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" ag integration (http://stackoverflow.com/a/17327372/1474757)
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" rg integration (http://www.wezm.net/technical/2016/09/ripgrep-with-vim/)
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Syntax highlighting *********************************************************
syntax on
set synmaxcol=1024 " limit syntax-highlighted columns for long lines

" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high
"match LongLineWarning '\%120v.*' " Error format when a line is longer than 120

" Line Wrapping ***************************************************************
set nowrap
set linebreak " Wrap at word

" File Stuff / File types / Autocommands **************************************

" let g:jsx_ext_required = 0 " treat js files as jsx.

function! JavaScriptFold()
  setl foldmethod=syntax
  setl foldlevelstart=1
  syn region javaScriptFunctionFold  start="{" end="}" transparent fold
  function! FoldText()
      return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setl foldtext=FoldText()
endfunction


filetype plugin indent on " Enable filetype-specific indenting and plugins
if has("autocmd")
  aug vimrc
    au!
    " To show current filetype use: set filetype
    au BufNewFile,BufRead config.ru,Gemfile,Vagrantfile,*.rsb,*.rabl set filetype=ruby
    au BufNewFile,BufRead *.jspf set ft=jsp
    au BufNewFile,BufRead .eslintrc set ft=json
    " au BufNewFile,BufRead *.json set ft=javascript
    au BufNewFile,BufRead *.js,*.jsx set ft=javascript.jsx
    au BufNewFile,BufRead *.tsx set ft=typescript.jsx

    au bufwritepost .vimrc,vimrc nested source $MYVIMRC
    " strip trailing white space on all lines
    autocmd vimrc BufWritePre * :call Preserve("%s/\\s\\+$//e")
    " au FileType html :set filetype=xhtml
    " au FileType javascript call JavaScriptFold()
    " au FileType javascript setl fen
  aug END
endif

" Language specific ***********************************************************

let g:ale_fixers = { 'elixir': ['mix_format'] }

" Swap and Backups ************************************************************

set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

" Time Savers *****************************************************************

nmap <leader>v :tabedit $MYVIMRC<CR>
cmap w!! w !sudo tee % >/dev/null
nnoremap ; :
map <S-Enter> O<ESC>
map <Enter> o<ESC>
" expand %% in command mode to directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" Misc ************************************************************************
set rtp+=~/.vim/bundle/tabnine-vim/

" set clipboard=unnamed
set backspace=indent,eol,start
set number " Show line numbers
" set relativenumber number " Show line numbers
"set matchpairs+=<:>
set vb t_vb= " Turn off bell
nmap <leader>p :set paste!<CR>

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

let g:localvimrc_whitelist = "/Users/martin/Development/.*/\.lvimrc"

inoremap <silent><expr> <c-space> coc#refresh()

