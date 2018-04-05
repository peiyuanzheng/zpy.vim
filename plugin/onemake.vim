
if exists("loaded_onemake")
    finish
endif
let loaded_onemake = 1

" just for .c and .cpp
function! s:SetOneFileMakeprg()
    if expand("%:p:h")!=getcwd()
        echohl WarningMsg | echo "Fail to make! This file is not in the current dir! " | echohl None
        return
    endif

    let sourcefilename=expand("%:t")
    if (sourcefilename=="" || (&filetype!="cpp" && &filetype!="c"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif

    let deletedspacefilename=substitute(sourcefilename,' ','','g')
    if strlen(deletedspacefilename)!=strlen(sourcefilename)
        echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
        return
    endif

    if &filetype=="c"
        set makeprg=gcc\ -O2\ -o\ %<\ %
    elseif &filetype=="cpp"
        "set makeprg=g++\ -O2\ -o\ %<\ %
        set makeprg=g++\ -O2\ -std=c++11\ -o\ %<\ %
    else
        return
    endif

endfunction


function! s:DoMake()
    let s:makeprg_saved = &makeprg

    " auto save
    execute "silent! wa"
    if !filereadable("Makefile")
        call <SID>SetOneFileMakeprg()
        execute "silent make"
    else
        execute "silent make -j6 -s"
    endif

    execute "copen"
    execute "redraw!"

    let &makeprg = s:makeprg_saved
    unlet s:makeprg_saved
endfunction

com! -nargs=0 OneMake :call <SID>DoMake()

