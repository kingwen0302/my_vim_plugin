" 自定义的评论插件
" 若中文无法争取显示,修改该文件的编码即可
"
"autocmd FileType *.[he]rl exec ":call <SID>SetComment()"
if !exists('g:MyComment_Author')
  let g:MyComment_Author = "zhaoming"
endif

if !exists('g:MyComment_Author_Email')
  let g:MyComment_Author_Email = "zhaoming@jieyoumail.com"
endif

function! <SID>SetCommentModule()
    ""let author="zhaoming"
    call append(0, "\%\% ===========================================================================")
    call append(1, "\%\% @doc")
    call append(2, "\%\% TODO 模块描述.")
    call append(4, "\%\% @end")
    call append(5, "\%\% ===========================================================================")
    call append(6, "-module(".expand("%:t:r").").")
    call append(7, "-author(".g:MyComment_Author.").")
    call append(8, "-version(1.0).")
    call append(9, "-date('".strftime("%Y-%m-%d")."').")
    call append(10, "")
    call append(11, "-export([]).")
    call cursor(3, 4)
endfunc

function! <SID>SetCommentModule1()
    call append(0, "\%\%\%-----------------------------------------------")
    call append(1, "\%\%\% @author zhaoming")
    call append(2, "\%\%\% @copyright ".strftime("%Y")." ChuangYu, Inc.")
    call append(3, "\%\%\% @since ".strftime("%Y-%m-%d")."")
    call append(4, "\%\%\% @doc")
    call append(5, "\%\%\%     ")
    call append(6, "\%\%\% @end")
    call append(7, "\%\%\%-----------------------------------------------")
    call append(8, "-module(".expand("%:t:r").").")
    call append(9, "")
    call append(10, "-export([]).")
    call cursor(6, 8)
endfunc

function! <SID>SetCommentFunction()
    call append(line(".")-1, "\%\% ---------------------------------------------------------------------------")
    call append(line(".")-1, "\%\% @doc TODO 函数描述.")
    call append(line(".")-1, "\%\% @spec ".expand("<cword>")."() -> ok. TODO 参数设置.")
    call append(line(".")-1, "\%\% ---------------------------------------------------------------------------")  
    call cursor(line(".")-3, 9)
endfunc

function! <SID>SetCommentFunction1()
    let sublines = 1
    let words = split(getline("."), '\W\+')
    let funcName = words[0]
    let words = words[1:len(words)]
    call append(line(".")-1, "\%\% @doc `<TODO 函数描述>`")
    let sublines += 1
    
    let argList = []
    for v in words
        if v == "when"
            break
        endif
        call add(argList, v)
    endfor

    let args = join(argList, ", ")
    
    call append(line(".")-1, "-spec " . funcName . "(" . args . ") -> Return when")
    let sublines += 1
    
    for v in argList
        call append(line(".") - 1, printf("    %-12s:: `<...>`,", v))
        let sublines += 1
    endfor
    call append(line(".")-1, printf("    %-12s:: `<...>`.", "Return"))
    let sublines += 1
    
    call append(line(".")-1, "")
    let sublines += 1
    call cursor(line(".")-sublines, 9)
endfunc

function! <SID>SetSimpleComment()
    call append(line(".")-1, "\%\% @doc TODO 函数描述")
    call cursor(line(".")-1, 9)
endfunc


command! -nargs=0 Cm call <SID>SetCommentModule1()
command! -nargs=0 Cf call <SID>SetCommentFunction()
command! -nargs=0 Cs call <SID>SetSimpleComment()
command! -nargs=0 Ca call <SID>SetCommentFunction1()
