set guioptions=a
set guifont=Monospace\ 8

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
set bs=2
set ch=2		" Make command line two lines high
set mousehide		" Hide the mouse when typing text
set nobackup
set nowritebackup
set noswapfile
set autoindent
set smartindent

" Set Color
colorscheme digerati
set t_Co=256

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif
filetype plugin indent on

  " Switch on search pattern highlighting.
set nohls
set incsearch
set showmatch

endif
