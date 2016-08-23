" Vim ftplugin file
" Language:     Erlang
" Author:       Oscar Hellstr枚m <oscar@oscarh.net>
" Contributors: Ricardo Catalinas Jim茅nez <jimenezrick@gmail.com>
"               Eduardo Lopez (http://github.com/tapichu)
" License:      Vim license
" Version:      2012/08/14
if exists('b:did_ftplugin')
    finish
else
    let b:did_ftplugin = 1
endif
if exists('s:did_function_definitions')
    call s:SetErlangOptions()
    finish
else
    let s:did_function_definitions = 1
endif
if !exists('g:erlang_keywordprg')
    let g:erlang_keywordprg = 'erl -man'
endif
if !exists('g:erlang_folding')
    let g:erlang_folding = 0
endif
let s:erlang_fun_begin = '^\a\w*(.*$'
let s:erlang_fun_end   = '^[^%]*\.\s*\(%.*\)\?$'
function s:SetErlangOptions()
    compiler erlang
    if version >= 700
        setlocal omnifunc=erlang_complete#Complete
    endif
    if g:erlang_folding
        setlocal foldmethod=expr
        setlocal foldexpr=GetErlangFold(v:lnum)
        setlocal foldtext=ErlangFoldText()
    endif
    setlocal comments=:%%%,:%%,:%
    setlocal commentstring=%%s
    setlocal formatoptions+=ro
    setlocal suffixesadd=.erl
    let &l:keywordprg = g:erlang_keywordprg
endfunction
function GetErlangFold(lnum)
    let lnum = a:lnum
    let line = getline(lnum)
    if line =~ s:erlang_fun_end
        return '<1'
    endif
    if line =~ s:erlang_fun_begin && foldlevel(lnum - 1) == 1
        return '1'
    endif
    if line =~ s:erlang_fun_begin
        return '>1'
    endif
    return '='
endfunction
" function ErlangFoldText()
" 	let line    = getline(v:foldstart)
" 	let foldlen = v:foldend - v:foldstart + 1
" 	let lines   = ' ' . foldlen . ' lines: ' . substitute(line, "[ \t]*", '', '')
" 	if foldlen < 10
" 		let lines = ' ' . lines
" 	endif
" 	let retval = '+' . v:folddashes . lines
" 
" 	return retval
" endfunction
" 原来的折叠不太好看, 修改如下
function ErlangFoldText()
    let maxchars = 79
    let line    = getline(v:foldstart)
    let foldlen = v:foldend - v:foldstart + 1
    " 删除")"及其以后的字符
    let splitlist = split(line, ')') 
    let function_name = strpart(line, 0, strlen(splitlist[0]) + 1)
    if foldlen < 10
        let lines = "[lines:" . " " . foldlen . "]"
    else
        let lines = "[lines:" . foldlen . "]"
    endif
    let name = "+" . v:folddashes . function_name
    let allfillchars = "-------------------------------------------------------------------------------"
    let fillchars = strpart(allfillchars, 0, maxchars - strlen(name) - strlen(lines))
    let retval = name . fillchars . lines
    return retval
endfunction
call s:SetErlangOptions()
" 旧版本的ErlangFoldText(), 备份下
" function s:GetFunName(str)
" 	return matchstr(a:str, '^\a\w*(\@=')
" endfunction
" 
" function s:GetFunArgs(str, lnum)
" 	let str = a:str
" 	let lnum = a:lnum
" 	while str !~ '->\s*\(%.*\)\?$'
" 		let lnum = s:GetNextNonBlank(lnum)
" 		if 0 == lnum " EOF
" 			return ""
" 		endif
" 		let str .= getline(lnum)
" 	endwhile
" 	return matchstr(str, 
" 		\ '\(^(\s*\)\@<=.*\(\s*)\(\s\+when\s\+.*\)\?\s\+->\s*\(%.*\)\?$\)\@=')
" endfunction
" 
" function s:CountFunArgs(arguments)
" 	let pos = 0
" 	let ac = 0 " arg count
" 	let arguments = a:arguments
" 	
" 	" Change list / tuples into just one A(rgument)
" 	let erlangTuple = '{\([A-Za-z_,|=\-\[\]]\|\s\)*}'
" 	let erlangList  = '\[\([A-Za-z_,|=\-{}]\|\s\)*\]'
" 
" 	" FIXME: Use searchpair?
" 	while arguments =~ erlangTuple
" 		let arguments = substitute(arguments, erlangTuple, "A", "g")
" 	endwhile
" 	" FIXME: Use searchpair?
" 	while arguments =~ erlangList
" 		let arguments = substitute(arguments, erlangList, "A", "g")
" 	endwhile
" 	
" 	let len = strlen(arguments)
" 	while pos < len && pos > -1
" 		let ac += 1
" 		let pos = matchend(arguments, ',\s*', pos)
" 	endwhile
" 	return ac
" endfunction
" 
" function ErlangFoldText()
" 	let foldlen = v:foldend - v:foldstart
" 	if 1 < foldlen
" 		let lines = "lines"
" 	else
" 		let lines = "line"
" 	endif
" 	let line = getline(v:foldstart)
" 	let name = s:GetFunName(line)
" 	let arguments = s:GetFunArgs(strpart(line, strlen(name)), v:foldstart)
" 	let argcount = s:CountFunArgs(arguments)
" 	let retval = "+" . v:folddashes . " " . name . "/" . argcount
" 	let retval .= " [" . foldlen . " " . lines . "]"
" 	return retval
" endfunction
