" Another .vimrc
" Suckless
" Author : Martin Lee

set nocompatible " You must set this first :)

" General
set autoread
set backspace=indent,eol,start
set nobackup
set nowritebackup
set noswapfile
set nowrap
set bs=2
set completeopt=longest,menuone
set expandtab
set history=50
set hlsearch
set ignorecase
set incsearch
set number
set ruler
set scrolloff=4
set shiftwidth=2
set showcmd
set showmatch
set showmode
set colorcolumn=80
set shell=/bin/bash
set smartcase
set smartindent
set smarttab
set tabstop=2
set title
set virtualedit=all
set wildmenu
set wildmode=list:longest,full

filetype plugin indent on
syntax on

" set the window title in screen
if $STY != ""
  set t_ts=k
  set t_fs=\
endif

" utf-8
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" fold
if has ('folding')
	set foldenable
	set foldmethod=marker
	set foldmarker={{{,}}}
	set foldcolumn=0
endif

" Terminal
if &t_Co >= 256
     colorscheme digerati
endif                     

if &t_Co > 2
        " switch syntax highlighting on, when the terminal has colors
   syntax on
endif

" GUI
if has("gui_running")
  set guifont=Consolas\ 9
  set antialias
  set background=dark
  colorscheme railcast
  set selectmode=mouse,key,cmd
  nnoremap <silent> <F2> :set nu!<cr> " Toggle line numbers
endif

" Python stuff
autocmd FileType python let python_highlight_all = 1
autocmd FileType python let python_slow_sync = 1
autocmd FileType python set expandtab shiftwidth=4 softtabstop=4
autocmd FileType python set completeopt=preview

" PKGBUILD stuff
autocmd FileType PKGBUILD set expandtab shiftwidth=2 softtabstop=4

" sh stuff
autocmd FileType sh set expandtab shiftwidth=2 softtabstop=4

" autocommands
au BufWritePost ~/.Xresources !xrdb ~/.Xresources

au BufRead * call SetStatusLine()
au BufReadPost * call RestoreCursorPos()
au BufWinEnter * call OpenFoldOnRestore()

au BufEnter * let &titlestring = "vim: " . substitute(expand("%:p"), $HOME, "~", '')
au BufEnter * let &titleold = substitute(getcwd(), $HOME, "~", '')

function! RestoreCursorPos()
  if expand("<afile>:p:h") !=? $TEMP
    if line("'\"") > 1 && line("'\"") <= line("$")
      let line_num = line("'\"")
      let b:doopenfold = 1
      if (foldlevel(line_num) > foldlevel(line_num - 1))
        let line_num = line_num - 1
        let b:doopenfold = 2
      endif
      execute line_num
    endif
  endif
endfunction

function! OpenFoldOnRestore()
  if exists("b:doopenfold")
    execute "normal zv"
    if(b:doopenfold > 1)
      execute "+".1
    endif
    unlet b:doopenfold
  endif
endfunction

function! SetStatusLine()
  let l:s1="%3.3n\\ %f\\ %h%m%r%w"
  let l:s2="[%{strlen(&filetype)?&filetype:'?'},\\ %{&encoding},\\ %{&fileformat}]\\ %{fugitive#statusline()}"
  let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
  execute "set statusline=" . l:s1 . l:s2 . l:s3
endfunction
