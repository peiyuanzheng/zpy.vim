"zpyadvance.vim - advance settings
"Maintainer: Peiyuan Zheng, peiyuanzheng@gmail.com
"Version: 1.0

"Install in $VIMRUNTIME/autoload
"add `call zpyadvance#config()` in .vimrc

if exists('g:loaded_zpyadvance') || &cp
    finish
endif
let g:loaded_zpyadvance = 1


function! zpyadvance#config() abort "{{{
    call <SID>ZpyGtags()
    call <SID>ZpyOneMake()
    call <SID>CPPHight()
    call <SID>Airline()
    call <SID>Ack()
    call <SID>Nerdtree()
    call <SID>Tagbar()
    call <SID>Ctrlp()
    call <SID>VimTmuxNavigator()
    call <SID>Ycm()
    "call <SID>Showmarks()
endfunction "}}}


function! s:CPPHight() "{{{
    let g:cpp_class_scope_highlight = 0
    let g:cpp_member_variable_highlight = 0
    let g:cpp_class_decl_highlight = 0
    let g:cpp_experimental_template_highlight = 0
    let g:cpp_concepts_highlight = 0
    let c_no_curly_error = 1
endfunction "}}}


function! s:Airline() "{{{
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tabline#buffer_nr_format = '%s:'
    "let g:airline#extensions#tabline#fnametruncate = 15
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
endfunction "}}}


function! s:Ack() "{{{
    if executable('ag')
        let g:ackprg = 'ag -U --vimgrep --ignore build'
    endif
    nnoremap <silent> <F2> :Ack <C-R>=expand("<cword>")<CR><CR>
    nnoremap <silent> <F3> :Ack -w <C-R>=expand("<cword>")<CR><CR>
endfunction "}}}


function! s:Nerdtree() "{{{
    let g:NERDChristmasTree = 1
    let g:NERDTreeDirArrows = 0
    let g:NERDTreeShowBookmarks = 1
    let g:NERDTreeShowHidden = 1
    let g:NERDTreeShowLineNumbers=1
    let g:NERDTreeWinSize = 40
    let g:NERDTreeIgnore = ['\.svn$', '\~$', '\.o$', '\.pyc$']
    nnoremap <silent> <F9> :NERDTreeToggle<CR>

    " open a NERDTree automatically when vim starts up if no files were specified
    autocmd vimenter * if !argc() | NERDTree | endif

    " close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
endfunction "}}}


function! s:Showmarks() "{{{
    let g:showmarks_auto_toggle = 0
    let g:showmarks_textlower = "@\t"
endfunction "}}}


function! s:Tagbar() "{{{
    let g:tagbar_width = 40
    nnoremap <silent> <F10> :TagbarToggle<CR>
endfunction "}}}


function! s:Ctrlp() "{{{
    set wildignore+=*.swp,*~
    nnoremap <leader>f :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
                \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc|jpg|png|jpeg)$',
                \ }
    let g:ctrlp_follow_symlinks = 1
endfunction "}}}


function! s:VimTmuxNavigator() "{{{
    " write the current buffer (only if changed) before navigating from Vim to tmux pane
    let g:tmux_navigator_save_on_switch = 1
    " Disable tmux navigator when zooming the Vim pane
    let g:tmux_navigator_disable_when_zoomed = 1
endfunction "}}}


function! s:ZpyGtags() "{{{
    let g:GtagsCscope_Auto_Map = 1
    let g:GtagsCscope_Auto_Load = 1
endfunction "}}}


" return true if left colomn is not empty charactor
function! s:IsLeftColValid() "{{{
    let col = col('.') - 1
    return col && getline('.')[col - 1] !~ '\s'
endfunction "}}}


function! s:ZpyOneMake() "{{{
    nnoremap <silent> <F7> :OneMake<CR>
endfunction "}}}


function! s:Ycm() "{{{
    nnoremap <leader>yd :YcmDiags<CR>
    nnoremap <leader>t :YcmCompleter GetType<CR>
    nnoremap <leader>g :YcmCompleter GoTo<CR>
    nnoremap <leader>ji :YcmCompleter GoToImprecise<CR>
    let g:ycm_show_diagnostics_ui = 1
    let g:ycm_error_symbol = '>*'
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0
    "let g:ycm_extra_conf_globlist = ['~/studio/*','!~/*']
    let g:ycm_complete_in_comments=1
    let g:ycm_seed_identifiers_with_syntax = 1
endfunction "}}}
