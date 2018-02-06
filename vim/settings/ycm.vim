let g:ycm_confirm_extra_conf = 0
Plugin 'Valloric/YouCompleteMe.git'
" See tag in preview
" noremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>
noremap <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <C-]> <C-O>:YcmCompleter GoToDefinitionElseDeclaration<CR>

    map <F5> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python %"
elseif &filetype == 'html'
            exec "!chrome % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!firefox %.html &"
endif
    endfunc

let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go': ['re!\w{2}']}
