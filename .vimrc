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
" Plugin 'vim-syntastic/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'rust-lang/rust.vim'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'pangloss/vim-javascript'

 " Vundle end
call vundle#end()            " required
filetype plugin indent on    " required

" Recursively source .lvimrc
function RecSourceVimrc(path)
	if !empty(globpath(a:path, "*"))
		let rcpath = a:path . "/.lvimrc"
		let parpath = a:path . "/.."
		so rcpath
		call RecSourceVimrc(parpath)
	endif
endfunction
" call RecSourceVimrc(".")

" Bind keys
map <ScrollWheelUp> <C-Y><C-Y><C-Y>
map <ScrollWheelDown> <C-E><C-E><C-E>
map <C-n> :NERDTreeToggle<CR>
map <F1> :SaveSession<CR>
map <F2> :OpenSession!<CR>

" Configure
let g:is_posix = 1
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set noexpandtab
set rnu
set nu
set so=5
let c_no_curly_error=1
":let g:session_autosave = 'no'
set iskeyword+=-
set linebreak
set fileencodings=utf-8
set encoding=utf-8
set lazyredraw

" Fix alt
execute "set <M-t>=\et"
execute "set <M-n>=\en"

" Visible tabs
set list
set listchars=tab:>—
hi tabs ctermfg=DarkGray
match tabs /\t/

 " Useful things
nmap <C-o> :
nmap \p :set paste!<CR>
nmap <C-c> <ESC>
imap <C-c> <ESC>
nmap <C-t> <ESC><Up>A<Enter>
imap <C-t> <ESC><Up>A<Enter>
nmap <M-t> <ESC>:m -2<Enter>
imap <M-t> <ESC>:m -2<Enter>i
nmap <M-n> <ESC>:m +1<Enter>
imap <M-n> <ESC>:m +1<Enter>i
if has("clipboard")
	noremap  y "+y
	noremap  Y "+Y
	noremap  p "+p
	noremap  P "+P
	vnoremap y "+y
	vnoremap Y "+Y
	vnoremap p "+p
	vnoremap P "+P
	vnoremap x "+x
	vnoremap X "+X
endif

vmap s/ :perldo s/
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

 " Search looks
hi Search cterm=NONE ctermfg=black ctermbg=yellow

 " Disable swp
set noswapfile

 " Dvorak: Fix navigation 
noremap h h
noremap t k
noremap n j
noremap s l
noremap <C-h> b
noremap <C-s> w
augroup dirmap_dvorak_fix
	autocmd!
	autocmd filetype nerdtree call Fix_dirmap_dvorak()
	autocmd filetype netrw call Fix_dirmap_dvorak()
augroup END
function! Fix_dirmap_dvorak()
	noremap <buffer> h h
	noremap <buffer> t k
	noremap <buffer> n j
	noremap <buffer> s l
endfunction

 " File types
au BufNewFile,BufRead *.nxc set filetype=c
au BufNewFile,BufRead *.pl6 set filetype=perl6

set colorcolumn=80
highlight ColorColumn ctermbg=0
highlight ColorColumn ctermfg=5

au BufNewFile,BufRead *.java imap sopl System.out.println("
au BufNewFile,BufRead *.java imap nmain class  {<Enter>public static void main(String[] args) {<Enter><Tab><Backspace><Enter>}<Enter>}<Up><Up><Up><Up><Right><Right><Right><Right><Right>
au BufNewFile,BufRead *.java command -nargs=1 Run :exec '!P=$(mktemp -u /tmp/vim.XXXXXXXX) && cp -r ' expand('%:p:h') ' $P && cd $P && javac *.java && java' <f-args> '; rm -r $P'
au BufNewFile,BufRead pascal2100/* BadTab

au BufNewFile,BufRead *.mdn set colorcolumn=0
au BufNewFile,BufRead *.mdn set updatetime=1500
au BufNewFile,BufRead *.mdn autocmd CursorHold,CursorHoldI <buffer> write
au BufNewFile,BufRead *.mdn imap ae æ
au BufNewFile,BufRead *.mdn imap aa å
au BufNewFile,BufRead *.mdn imap oe ø
au BufNewFile,BufRead *.mdn imap Ae Æ
au BufNewFile,BufRead *.mdn imap Aa Å
au BufNewFile,BufRead *.mdn imap noe no e<Left><Backspace><Right>
au BufNewFile,BufRead *.mdn imap Noe No e<Left><Backspace><Right>
au BufNewFile,BufRead *.mdn imap metae meta e<Left><Backspace><Right>
au BufNewFile,BufRead *.mdn imap Metae Meta e<Left><Backspace><Right>
au BufNewFile,BufRead *.mdn imap Oe Ø
au BufNewFile,BufRead *.mdn set filetype=markdown.pandoc

au BufNewFile,BufRead *.md set tw=79
au BufNewFile,BufRead *.md set filetype=markdown

au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.rs set filetype=rust

au BufNewFile,BufRead *.fxml set filetype=xml

au BufNewFile,BufRead *.html imap htinit <!DOCTYPE html><Enter><html><Enter><head><enter><meta charset="utf-8"><enter><title></title><enter></head><enter><body><enter></body><enter></html><Up><Up><Up><Up><Right><Right><Right><Right><Right><Right><Right><Right>
au BufNewFile,BufRead *.html imap htag <Esc>vbyi<<Esc>A></<Esc>pi<Right>><Esc>bb<Right>i

au BufNewFile,BufRead *.json imap tag <Esc>bi"<Esc>A":<Space>

au BufNewFile,BufRead *.h imap hguard <Esc>A_H<Esc>^gU$y$i#ifndef <Esc>A<Return>#define <Esc>pA<Return><Esc>GA<Return>#endif

au BufNewFile,BufRead *.vue set filetype=html

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Multiple Cursors
let g:multi_cursor_quit_key='<C-c>'

" No, rust, I don't want your stinking spaces
let g:rust_recommended_style = 0

" I don't want sql key maps
let g:omni_sql_no_default_maps = 1

" Lisp deserves special whitespace settings
au Filetype scheme setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" ASM should probably have 8 long tabs
au Filetype asm setlocal tabstop=8 shiftwidth=8
