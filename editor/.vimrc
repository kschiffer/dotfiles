" === General Settings ===
set hidden
set nowrap
set scrolloff=16
set sidescrolloff=20
set list
set undofile
set spell
set smartcase
set splitright
set backup
set confirm
set encoding=UTF-8
set laststatus=2
set relativenumber
set backupdir=~/.vim/backup
set showtabline=0
set background=dark
set autoread
set clipboard=unnamed
set incsearch
set termguicolors

" === Display & Colors ===
syntax on
filetype plugin indent on
set cursorline
set cursorcolumn
set number
highlight LineNr ctermbg=234

" Gruvbox Colorscheme
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
autocmd vimenter * ++nested colorscheme gruvbox

" === Indentation ===
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set noautoindent
set softtabstop=0
set nocindent
set smarttab

" === NERDTree Settings ===
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeIgnore = ['^node_modules$']
autocmd VimEnter * if &filetype !=# 'gitrebase' | NERDTree | wincmd p | endif
autocmd VimEnter * if &filetype != 'gitrebase' && argc() == 0 | NERDTree | wincmd p | endif
autocmd BufEnter * if winnr('$') == 1 && exists('t:NERDTreeBufName') && bufname() == t:NERDTreeBufName | quit | endif

" === ALE & Prettier ===
let g:ale_fixers = {'javascript': ['eslint'], 'stylus': ['stylelint']}
let g:ale_sign_error = '😂'
let g:ale_sign_warning = '🤔'
let g:ale_fix_on_save = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

" === Key Mappings ===
nnoremap <Leader>nt :NERDTree<Enter>
nnoremap <c-s> :w<CR>
nmap <Leader>vimrc :e ~/.vimrc<cr>
nmap <Leader>[ :bp<cr>
nmap <Leader>] :bn<cr>
map <Leader>yw cw<C-r>0<ESC>
map gf :edit <cfile><cr>
nnoremap gb :buffers<cr>:buffer<Space>
nnoremap <silent> <Leader>fif :Rg<cr>
nnoremap <silent> <Leader>fifjs :Rgjs<cr>
nnoremap <Leader>ogh :OpenGithub<cr>
nnoremap <Leader>F :exec 'Rg '.expand('<cword>')<cr>
nmap <c-p> :GFiles<cr>

" Updated Pane Switching Keybindings
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" === Git Commit Auto-Insert ===
autocmd FileType gitcommit exec 'au VimEnter * startinsert'

" === Cursor Color Based on Mode ===
function! SetCursorLineNrColorInsert(mode)
    if a:mode == "i"
      hi StatusLine guifg=green guibg=#333333
      hi LineNr guifg=green
    endif
endfunction

function! ResetCursorLineNrColor()
    hi StatusLine guibg=lightgray guifg=#333333
    hi LineNr guifg=#555555
endfunction

augroup CursorLineNrColorSwap
    autocmd!
    autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * call ResetCursorLineNrColor()
    autocmd CursorHold * call ResetCursorLineNrColor()
augroup END

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" === File-Specific Rg Search ===
command! -bang -nargs=* Rgjs call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -g "*.js" -g "*.ts" -g "*.vue" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rggo call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -g "*.go" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* Rgstyl call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -g "*.styl" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

" === Plugins ===
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'prettier/vim-prettier', {'do': 'yarn install --frozen-lockfile --production', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html']}
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'brooth/far.vim'
Plug 'github/copilot.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
call plug#end()
