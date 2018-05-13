" colors <<
syntax on                  " enable syntax highlighting
filetype plugin indent on  " enable filetyp and indentation
set cursorline             " highlight cursor line
set number                 " enable linenumbers
" >>

" indentation <<
set softtabstop=0 " don't use soft tabstops
set tabstop=2     " width of tab character
set shiftwidth=2  " > > moves 4 spaces
set shiftround    " > and < round to shiftwidth
set expandtab     " expand tabs to spaces
set smarttab      " backspace over expand tabs
set noautoindent  " don't autoindent
set smartindent   " do use smartindent
set nocindent     " no strict indentation
" >>

" open commits in insert mode <<
autocmd FileType gitcommit exec 'au VimEnter * startinsert'
" >>
