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
    "call <SID>Minibufexpl()
    "call <SID>Showmarks()
    "call <SID>Neocomplcache()
    "call <SID>DoxygenToolkit()
    "call <SID>Workspace()
    "call <SID>Syntastic()
    "call <SID>JediVim()
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


function! s:Minibufexpl() "{{{
    let g:miniBufExplorerMoreThanOne=1
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


function! s:Neocomplcache() "{{{
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_disable_auto_complete = 0
    let g:neocomplcache_enable_auto_select = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 0
    let g:neocomplcache_auto_completion_start_length = 2
    let g:neocomplcache_min_syntax_length = 3

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " mappings
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-e> neocomplcache#cancel_popup()
    inoremap <expr><BS> neocomplcache#smart_close_popup() ."\<BS>"

    inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    "inoremap <expr><SPACE> pumvisible() ? neocomplcache#close_popup() . "\<SPACE>" : "\<SPACE>"
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>IsLeftColValid() ? "\<C-x>\<C-u>" : "\<TAB>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
endfunction "}}}


function! s:DoxygenToolkit() "{{{
    let g:DoxygenToolkit_authorName="zhengpeiyuan(zhengpeiyuan@baidu.com)"
    let g:DoxygenToolkit_licenseTag="Copyright (c) XXX. All Rights Reserved\<enter>"
    let g:DoxygenToolkit_briefTag_pre = "@brief "
    let g:DoxygenToolkit_paramTag_pre = "@param "
    let g:DoxygenToolkit_returnTag = "@return "
    let g:DoxygenToolkit_briefTag_funcName = "no"
    let g:DoxygenToolkit_maxFunctionProtoLines = 30
endfunction "}}}


function! s:AddCommonIncludePaths() "{{{
    let &path = &path . ',/usr/include/c++/4.9'
    let &path = &path . ',/usr/include/x86_64-linux-gnu/c++/4.9'
    let &path = &path . ',/usr/include/c++/4.9/backward'
    let &path = &path . ',/usr/lib/gcc/x86_64-linux-gnu/4.9/include'
    let &path = &path . ',/usr/lib/gcc/x86_64-linux-gnu/4.9/include-fixed'
    let &path = &path . ',/usr/local/include'
    let &path = &path . ',/usr/include'
endfunction "}}}


function! s:AddOtherIncludePaths(ifile) "{{{
    if filereadable(a:ifile)
        for line in readfile(a:ifile)
            if line =~ '^-I'
                let line = substitute(line, '^-I', '', 'g')
                if line =~ '^./'
                    let line = substitute(line, '^./', '', 'g')
                endif
                let &path = &path . ',' . line
            endif
        endfor
    endif
endfunction "}}}


function! s:Workspace() "{{{
    call <SID>AddCommonIncludePaths()
    call <SID>AddOtherIncludePaths('.clang_complete')
    if filereadable("workspace.vim")
        source workspace.vim
    endif
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

function! s:Syntastic() "{{{
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_enable_balloons = 0
    let g:syntastic_auto_jump = 1
    "let g:syntastic_auto_loc_list = 1
    "let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_error_symbol = 'E>'
    let g:syntastic_warning_symbol = 'W>'
    let g:syntastic_mode_map = { 'mode': 'passive',
                               \ 'active_filetypes': ['lua', 'go', ],
                               \ 'passive_filetypes': [] }
    let g:syntastic_python_checkers = ['pylint', 'python', ]

    nnoremap <silent> <F6> :SyntasticCheck<CR>
    nnoremap <silent> [n :lprev<CR>
    nnoremap <silent> ]n :lnext<CR>
endfunction "}}}


function! s:JediVim() "{{{
    " disable auto select first candidate to compatible of neocomplcache
    "let g:jedi#auto_initialization = 1
    let g:jedi#popup_on_dot = 0
    autocmd FileType python let b:did_ftplugin = 1

    let g:jedi#use_tabs_not_buffers = 0
    let g:jedi#completions_command = "<C-N>"
    let g:jedi#goto_assignments_command = "<leader>a"
endfunction "}}}

