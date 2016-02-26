func! Rect_line_numbers(...)
    if(a:firstline == line('.'))
        if(exists('a:1')) | let sns = a:1 | else | let sns = 0 | endif
        if(exists('a:2')) | let fms = a:2 | else | let fms = '%d' | endif
        let pos = getpos('.')
        let pos[2] = col("'<")
        for curline in range(a:firstline, a:lastline)
            let pos[1] = curline
            call setpos('.', pos)
            exec 'normal i' . printf(fms, sns)
            let sns += 1
        endfor
    endif
endfunc
command! -range -nargs=* Rln :<line1>,<line2>call Rect_line_numbers(<f-args>)
"在所选区域每列的开头插入标号(也可以是格式化字符串），就是类似emacs c-x r N了
"安装：丢到vimrc里
"用法：选择一块区域，:Rln即可
":{range}Rln
    "默认从0开始增长
":{range}Rln sn
    "sn是开始的数字，可以是负数
":{range}Rln sn fs
    "sn同上
    "fs是格式化字符串，格式与printf相同，当然别整换行符之类的东东
"如果省略{range}则在当前行开头添加
"例如:
" Rln 1 %d.\  
