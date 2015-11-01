set nocompatible               " be iMproved
filetype off                   " required!
silent exec '!stty -ixon'

 " Pachogen
call pathogen#infect()
syntax enable
filetype plugin indent on

 " Vundle start
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

 " Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'

 " Vundle end
call vundle#end()            " required
filetype plugin indent on    " required

" Bind keys
map <ScrollWheelUp> <C-Y><C-Y><C-Y>
map <ScrollWheelDown> <C-E><C-E><C-E>
map <C-n> :NERDTreeToggle<CR>
map <F1> :SaveSession<CR>
map <F2> :OpenSession!<CR>

" Configure
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set rnu
:let g:session_autosave = 'no'

" Replace characters
set list
set listchars=tab:>.

 " Useful things
nmap <C-o> :
nmap \p :set paste!<CR>
nmap <C-c> <ESC>
imap <C-c> <ESC>
command BadTab call SetBadTab()
function SetBadTab()
	:set expandtab
	:set smarttab
endfunction
command -nargs=* Draw :exec '!mdraw' expand('%:p:h') <f-args>
set modeline
set modelines=1

 " Search options
set incsearch
set ignorecase
set smartcase
set hlsearch

 " Disable swp
set noswapfile

 " Dvorak: Fix navigation 
noremap h h
noremap t k
noremap n j
noremap s l
noremap <C-h> b
noremap <C-s> w

 " Dvorak: Fix control keys
noremap a v
noremap o y
noremap e p

 " Make nxc look like C
au BufNewFile,BufRead *.nxc set filetype=c

set colorcolumn=80

au BufNewFile,BufRead *.java imap sopl System.out.println("
au BufNewFile,BufRead *.java imap nclass class  {<Enter>public static void main(String[] args) {<Enter><Tab><Backspace><Enter>}<Enter>}<Up><Up><Up><Up><Right><Right><Right><Right><Right>
au BufNewFile,BufRead *.java command -nargs=1 Run :exec '!P=$(mktemp -u /tmp/vim.XXXXXXXX) && cp -r ' expand('%:p:h') ' $P && cd $P && javac *.java && java' <f-args> '; rm -r $P'

au BufNewFile,BufRead *.md set colorcolumn=0
set updatetime=1500
au BufNewFile,BufRead *.md autocmd CursorHold,CursorHoldI <buffer> write
au BufNewFile,BufRead *.md imap ae æ
au BufNewFile,BufRead *.md imap aa å
au BufNewFile,BufRead *.md imap oe ø
au BufNewFile,BufRead *.md imap Ae Æ
au BufNewFile,BufRead *.md imap Aa Å
au BufNewFile,BufRead *.md imap Oe Ø

" Syntastic
let g:loaded_syntastic_java_javac_checker = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Multiple Cursors

let g:multi_cursor_quit_key='<C-c>'
