"-----------------------------------------------------------------------------
" Buzz's vimrc
" Yao-Lun Ku <ylku.buzz[At]gmail[Dot]com>
" https://github.com/ylku/VIM
"-----------------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jlanzarotta/bufexplorer'
Plug 'bogado/file-line'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
"Plug 'kien/ctrlp.vim'  # replace by fzf
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim' " For :Ag

" vim-snipmate requires snippets, vim-addon-mw-utils and tlib
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'

" Colorscheme and syntax highlight
Plug 'morhetz/gruvbox'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/seoul256.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

colorscheme gruvbox
"colorscheme seoul256

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction


"----------------------------------------------------------------------------
" General setting
"----------------------------------------------------------------------------
set colorcolumn=80     " Right margin "
set nocompatible                " not compatible with the old-fashion vi mode
set ruler                               " show the cursor position all the time
set cursorline          " highlight current line "
"highlight CursorLine          guibg=#003853 ctermbg=255  gui=none cterm=none
set autoread            " auto read when file is changed from outside
set laststatus=2
set history=50          " keep 50 lines of command line history
set showmode                    " Show current mode
set showmatch                   " Cursor shows matching ) and }
set wildchar=<TAB>              " Start wild expansion in the command line using <TAB>
set wildmenu                    " wild char competion menu
set bs=2                " allow backspacing over everything in insert mode

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" auto reload vimrc when editing it
autocmd! bufwritepost .config/nvim/init.vim source ~/.config/nvim/init.vim

" ignore these files while expanding wild chars
set wildignore=*.o,*.dep

set noerrorbells        " Disable sound on errors "
set novisualbell        " Disable visual bell "

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"----------------------------------------------------------------------------
"           TAB setting
"----------------------------------------------------------------------------
" Replace <TAB> with space.
" Hitting Tab in insert mode will produce the appropriate number of spaces
"----------------------------------------------------------------------------
set expandtab           " replace <TAB> with spaces
set softtabstop=4

" Set shiftwidth to control how many columns text is indented with the reindent
" operations (<< and >>) and automatic C-style indentation.
set shiftwidth=4    " Vim incident <n> space
set tabstop=4       " tell vim how many columns a tab counts for
"set smarttab                   " insert tabs on the start of a line according to context

au FileType Makefile set noexpandtab " Do not expandtab while type is Makefile

" Visualizing tabs
syntax match Tab /\t/
hi Tab gui=underline guifg=blue ctermbg=blue

set list
set listchars=tab:>-

"----------------------------------------------------------------------------
"               Format automatically
"----------------------------------------------------------------------------
set autoindent
set cindent
set comments=sl:/*,mb:**,elx:*
set copyindent      " copy the previous indentation on autoindenting
"set smartindent

"----------------------------------------------------------------------------
"               Searching
"----------------------------------------------------------------------------
set hlsearch            " highlight search
set incsearch           " incremental search
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,case-sensitive otherwise

"----------------------------------------------------------------------------
"               Mapping (map, nmap, ...)
"----------------------------------------------------------------------------
" Replace leader with , (default is \)
let mapleader=","
let g:mapleader=","

" Use :update to reprace :w(Vim only).
" Save file if there is any change
map <F2> :up<CR>
"save and exit
map <F3> :up<CR>:q<CR>
"exit without saving
map <F4> :q!<CR>

"Toggle on/off syntax_on
map <F7> :if exists("syntax_on") <BAR>
     \   syntax off <BAR><CR>
          \ else <BAR>
               \   syntax enable <BAR>
                    \ endif <CR>

"nnoremap <silent> <leader>ne :NERDTreeToggle<CR>
nnoremap <silent> <F8> :NERDTreeToggle<CR>

" To start exploring in the current window, use: > \be   or   :BufExplorer
"nnoremap <leader>be <ESC>:BufExplorer<CR>
nnoremap <F9> <ESC>:BufExplorer<CR>
" To start exploring in a newly split horizontal window, use: > \bs   or   :BufExplorerHorizontalSplit
map <leader>bs <ESC>:BufExplorerHorizontalSplit<CR>
" To start exploring in a newly split vertical window, use: > \bv   or   :BufExplorerVerticalSplit
map <leader>bv <ESC>:BufExplorerVerticalSplit<CR>

" Toggle TagBar
"nnoremap <leader>tt :TagbarToggle<CR>
nnoremap <F10> :TagbarToggle<CR>

" Toggle on/off highlight Search
nmap <leader>hl :set hls!<BAR>set hls?<CR>

" Toggle on/off paste mode
"map <leader>ps :set paste!<BAR>set paste?<CR>
set pastetoggle=<leader>ps

" +--------------------------------+
" |         split windows          |
" +--------------------------------+
" Move to and maximize the below split
map <C-J> <C-W>j<C-W>_
" Move to and maximize the above split
map <C-K> <C-W>k<C-W>_
" Move to and maximize the right split
nmap <C-H> <C-W>l<C-W><bar>
" Move to and maximize the left split
nmap <C-L> <C-W>h<C-W><bar>


" +--------------------------------+
" |         Indentation            |
" +--------------------------------+
" Multiline indent/un-indent (V mode)
vmap > >gv
vmap < <gv
" Current line indent/un-indent (N mode)
nmap > v><ESC>
nmap < v<<ESC>


" +--------------------------------+
" |             ctags              |
" +--------------------------------+
" Ctrl+T, Navigating to the function definition from ‘function call’
map <C-N> <C-T>
" Ctrl+], Returning back again to function call from the definition
map <C-M> <C-]>

" +--------------------------------+
" |            Cscope              |
" +--------------------------------+

if has("cscope") && filereadable("/usr/bin/cscope")
    "nmap <F5> :call UpdateCscopeDatabase() <CR>
    set csprg=/usr/bin/cscope
    set csto=0
    set cst

    " add any database in current directory
    if filereadable("cscope.out")
      cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose

    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    function! UpdateCscopeDatabase()
        :cs kill 0
        :cs add cscope.out
    endfunction
endif


"show lines with matching word under cursor
nmap <leader>lns [I

"========== imap ============
"example: imap ;so System.out.println();<left><left>
"example: imap ;ne <esc>/;<cr>a


"----------------------------------------------------------------------------
"             Encoding
"----------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

"----------------------------------------------------------------------------
"           Plugin (.vim/bundle/*)
"----------------------------------------------------------------------------
" +--------------------------------+
" |         EasyMotion             |
" +--------------------------------+
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
nmap <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"hi link EasyMotionTarget ErrorMsg
"hi link EasyMotionShade  Comment

" +--------------------------------+
" |         vim-airline            |
" +--------------------------------+
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" +--------------------------------+
" |            nerdtree            |
" +--------------------------------+


" +--------------------------------+
" |            bufexplorer         |
" +--------------------------------+

" +--------------------------------+
" |            fzf                 |
" +--------------------------------+
set rtp+=~/.fzf      " set runtimepath of fzf installation path

command! -bang ObmcFiles
    \ call fzf#vim#files('~/projects/aci/obmc-repo',{'options': ['--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nmap <C-P> :Files<CR>
nmap <F12> :RG<CR>

" +--------------------------------+
" |             Tagbar             |
" +--------------------------------+
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" +--------------------------------+
" |      YouCompleteMe             |
" +--------------------------------+
"let g:ycm_global_ycm_extra_conf = '/home/bku/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0

" +--------------------------------+
" | vim-cpp-enhanced-highlight     |
" +--------------------------------+
" syntax highlight for C++11/14/17
let g:cpp_class_scope_highlight = 0
let g:cpp_member_variable_highlight = 1

