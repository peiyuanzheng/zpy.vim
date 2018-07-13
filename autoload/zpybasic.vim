"zpybasic.vim - basic settings
"Maintainer: Peiyuan Zheng, peiyuanzheng@gmail.com
"Version: 1.0

"Install in $VIMRUNTIME/autoload
"add `call zpybasic#config()` in .vimrc

if exists('g:loaded_zpybasic') || &cp
    finish
endif
let g:loaded_zpybasic = 1


function! zpybasic#config() abort "{{{
    call <SID>Common()
    call <SID>HoldLastCursorPosition()
    call <SID>Mapping()
endfunction "}}}


function s:Common() "{{{
    syntax enable
    syntax on
    filetype plugin indent on

    set t_Co=256
    set background=dark
    colorscheme gruvbox
    set fileencodings=utf-8,euc-cn,cp936,latin1,gb18030     " euc-cn is gbk
    set encoding=utf-8
    set termencoding=utf-8
    set fileencoding=utf-8
    set tabstop=4                    " set tab width
    set shiftwidth=4
    set expandtab
    set smarttab
    set autoindent
    set smartindent
    " fix no indent when input '#' as first character
    autocmd FileType python inoremap # X<c-h>#
    set matchpairs=(:),{:},[:],<:>
    set showmatch                    " auto match, eg. ()
    set showcmd
    set vb t_vb=                    " don't make noise 
    set backspace=2                    " enable Backspace
    set backspace=indent,eol,start    " allow backspacing over everything in insert mode
    set whichwrap=b,s,<,>,[,]
    set linebreak
    set history=100     " set how many lines of history VIM has to remeber
    set autoread        " set to auto read when a file is changed from the outside
    set number
    set noswapfile
    set noundofile
    set hidden
    set scrolloff=2
    set listchars=tab:>-,trail:-,nbsp:%,eol:$
    set textwidth=100
    " highlight column after 'textwidth'
    set colorcolumn=+1
    set wildignore=*.o,*.obj,*.bak,*~,*.exe,*.pyc

    "----- about search and replace
    "set ignorecase
    set smartcase
    set incsearch
    set hlsearch

    "----- about status bar
    "set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
    "set statusline=
    "set statusline+=%-3.3n\                      " buffer number
    "set statusline+=%f\                          " filename
    "set statusline+=%h%m%r%w                     " status flags
    "set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
    "set statusline+=%=                           " right align remainder
    "set statusline+=0x%-8B                       " character value
    "set statusline+=%-14(%l,%c%V%)               " line, character
    "set statusline+=%<%P                         " file position
    "set laststatus=2                " always show the status bar
    "set ruler                       " show the cursor position all the time

    "----- highlight cursor position
    "set cursorline
    autocmd FileType python setlocal cursorcolumn

    "----- fold
    "set foldmethod=syntax
    set foldmethod=indent
    set foldlevel=100

    set mouse=
endfunction "}}}


function s:Mapping() "{{{
    "----- shortcuts about split
    nnoremap wv <C-w>v
    nnoremap wc <C-w>c
    nnoremap ws <C-w>s

    "----- shortcuts about move among windows
    noremap <C-H> <C-W>h
    noremap <C-J> <C-W>j
    noremap <C-K> <C-W>k
    noremap <C-L> <C-W>l

    "----- netrw
    let g:netrw_winsize=30
    nnoremap <silent> <leader>fe :Sexplore!<CR>

    "----- about vimrc
    nnoremap <silent><leader>sr :source ~/.vimrc<cr>
    nnoremap <silent><leader>er :e ~/.vimrc<cr>
    autocmd! bufwritepost .vimrc source ~/.vimrc

    "----- autoclose '{' and indent
    inoremap {{ {<CR>}<Esc>ko

    "----- turn hlsearch off/on with CTRL-N
    nnoremap <silent> <C-N> :se invhlsearch<cr>

    "----- write file and redraw window
    nnoremap <silent><leader>w :w!<cr>:redraw!<cr>
endfunction "}}}


function s:HoldLastCursorPosition() "{{{
    " always jump to the last known cursor position
    " copy from vimrc_example.vim
    if has("autocmd")
        augroup vimrcEx
            au!
            " When editing a file, always jump to the last known cursor position.
            " Don't do it when the position is invalid or when inside an event handler
            " (happens when dropping a file on gvim).
            " Also don't do it when the mark is in the first line, that is the default
            " position when opening a file.
            autocmd BufReadPost *
                        \ if line("'\"") > 1 && line("'\"") <= line("$") |
                        \   exe "normal! g`\"" |
                        \ endif
        augroup END
    endif
endfunction "}}}

