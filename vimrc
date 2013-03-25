set nocompatible

if has("syntax")
  syntax on
endif

filetype plugin indent on " Enable filetype-specific indenting and plugins

" run source after saving .vimrc
autocmd bufwritepost .vimrc source $MYVIMRC

augroup file_php
  autocmd!
  "autocmd FileType php set tags=./tags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType php let php_sql_query=1
  autocmd FileType php let php_htmlInStrings=1
  " need to reset syntax because of lets above
  autocmd FileType php set syntax=php
  autocmd FileType php,html,css,ruby,javascript set ts=2 sw=2 sts=2 et ai
  autocmd FileType php runtime! ftplugin/html/sparkup.vim
  "autocmd FileType php exe 'set t_kB=' . nr2char(27) . '[Z'
augroup END

" lets
let g:SuperTabClosePreviewOnPopupClose = 1
let mapleader = ","

" <Leader> maps
map <Leader>sp :set paste<CR>
map <Leader>snp :set nopaste<CR>
map <Leader>l :!/usr/bin/env php -l %<CR>
map <Leader>t :w ~/.tmp/_<CR>:!/usr/bin/env php -l ~/.tmp/_<CR>:!rm ~/.tmp/_<CR>
map <Leader>rs :!/usr/bin/env php %<CR>
map <Leader>tp :!tail /var/log/php.log<CR>
map <Leader>v :tabedit $MYVIMRC<CR>
map <Leader>o :CommandT<CR>
map <Leader>q :q<CR>
map <Leader>wq :wq<CR>
map <Leader>e :e <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>s :split <C-R>=expand("%:p:h") . '/'<CR>
map <Leader>sv :vnew <C-R>=expand("%:p:h") . '/'<CR>
nmap <Leader>i :set list!<CR>
imap <Leader>, <c-x><c-o>
imap <Leader>. <c-x><c-p>

" sets
"set hidden " enable hidden buffers
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=500   " keep 500 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set showmatch
set nowrap
set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set wmh=0
set viminfo+=!
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set number 
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light
set splitbelow
set splitright
set timeoutlen=500 " 500 ms delay for leader key maybe
set formatoptions-=cro " disables comment behavoir autowrap, auto on CR
set scrolloff=5 " keep 5 lines above scrolls

" manage list chars
set listchars=""
set listchars=tab:▸\
set listchars+=trail:·
set listchars+=eol:¬
set listchars+=extends:◄
set listchars+=precedes:►

"set tags=./tags; " Set the tag file search order
set noesckeys " Get rid of the delay when hitting esc!
"set grepprg=ack

" Make the omnicomplete text readable
highlight PmenuSel ctermfg=black

" Highlight the status line
"highlight StatusLine ctermfg=blue ctermbg=yellow

" imaps
imap <c-e> <c-o>$
" disabled <c-a> because of tmux
" imap <c-a> <c-o>^ 

" maps
"map <C-s> <esc>:w<CR>
"imap <C-s> <esc>:w<CR>
" instead of 0 going to col1 goto first non-empty
map 0 ^

" vmaps
vnoremap > ><CR>gv 
vnoremap < <<CR>gv 

command! Q q " Bind :Q to :q
command! W w " Bind :W to :w

" ctrlp ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jpg|gif|png|zip|tar|gz)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
