" ---------------------------------------------------------------------------- "
" General Mappings                                                             "
" ---------------------------------------------------------------------------- "

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

map <C-J> :bprev<CR>
map <C-K> :bnext<CR>

" Close buffer
noremap <Leader>c :bd<CR>

" Clear search highlight
nnoremap <silent> <Leader><space> :noh<CR>

" Toggle wrap mode
nnoremap <Leader>wr :set wrap!<CR>

" Fast save
nnoremap <Leader><Leader> :w<CR>

" spell check
map <silent> <F6> :setlocal spell! spelllang=en<CR>
map <silent> <F7> :setlocal spell! spelllang=de<CR>

" Spell error: pick the first result
nnoremap <Leader>z z=1<CR><CR>

" Fix spelling mistakes on the fly
inoremap <C-S> <C-G>u<Esc>[s1z=`]a<C-G>u

" Disable Arrow keys in Escape mode
map <Up> <nop>
map <Down> <nop>
map <Left> <nop>
map <Right> <nop>

" Disable Arrow keys in Insert mode
imap <Up> <nop>
imap <Down> <nop>
imap <Left> <nop>
imap <Right> <nop>

" Disable ex mode shortcut
nmap Q <Nop>

" Format JSON with jq
nnoremap <silent> <Leader>fj :%!jq '.'<CR>

" [,* ] Search and replace the word under the cursor.
" current line
nmap <Leader>* :s/\<<C-r><C-w>\>//g<Left><Left>
" all occurrences
nmap <Leader>** :%s/\<<C-r><C-w>\>//g<Left><Left>

" w!! to save with sudo
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" replace word with text in register "0
nnoremap <Leader>pr viw"0p

" Switch CWD to the directory of the open buffer
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Close quickfix window (,qq)
map <Leader>qq :cclose<CR>

" List contents of all registers
nnoremap <silent> "" :registers<CR>

" add semicolon at end of line
map <Leader>; g_a;<Esc>

" tmux style shortcuts
nnoremap <C-W>% :split<CR>
nnoremap <C-W>" :vsplit<CR>

" remain in visual mode after code shift
vnoremap < <gv
vnoremap > >gv