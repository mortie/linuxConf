call plug#begin('~/.local/share/nvim/plugged')
Plug 'terryma/vim-multiple-cursors'
Plug 'editorconfig/editorconfig-vim'
Plug 'justinmk/vim-syntax-extra'
call plug#end()

" Config
set tabstop=4
set shiftwidth=4
set noexpandtab
set nu
set rnu
set laststatus=0
set so=5
set noswapfile
set ignorecase
set smartcase
if has('clipboard')
	set clipboard=unnamedplus
	nnoremap d "_d
	vnoremap d "_d
endif

" Visible tabs
set list
set listchars=tab:>—
hi tabs ctermfg=DarkGray
match tabs /\t/

" Bind keys
noremap h h
noremap t k
noremap n j
noremap s l
noremap <C-h> b
noremap <C-s> w

" Useful shortcuts
imap <C-t> <ESC>^i<Enter><Up>
nmap <C-t> <ESC>^i<Enter><Up>
imap <C-c> <ESC>
nmap <C-c> <ESC>

" Look
highlight Comment ctermfg=lightblue cterm=italic

" Plugin config stuff
let g:multi_cursor_quit_key='<C-c>'

" File type specific things
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
au BufNewFile,BufRead *.c imap cinit #include <stdio.h><Enter><Enter>int main(int argc, char **argv) {<Enter>return 0;<Enter>}<Up><Up><Esc>A<Enter>
au BufNewFile,BufRead *.cc imap cinit #include <stdio.h><Enter><Enter>int main(int argc, char **argv) {<Enter>return 0;<Enter>}<Up><Up><Esc>A<Enter>

au BufNewFile,BufRead *.json imap tag <Esc>bi"<Esc>A":<Space>

au BufNewFile,BufRead *.h imap hguard <Esc>A_H<Esc>^gU$y$i#ifndef <Esc>A<Return>#define <Esc>pA<Return><Esc>GA<Return>#endif

au BufNewFile,BufRead *.vue set filetype=html
