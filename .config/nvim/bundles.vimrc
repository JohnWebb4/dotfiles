"  =========================================
"     Dependencies
"  =========================================
" Plug 'tpope/vim-repeat'

"  =========================================
"    Config Variables
"  =========================================
let s:uname = system("uname -s")

"  =========================================
"     Colorschemes
"  =========================================
Plug 'flazz/vim-colorschemes'

" Plug 'felixhummel/setcolors.vim'
" nnoremap <Leader>= :call NextColor(1)<CR>
" nnoremap <Leader>- :call NextColor(-1)<CR>

"  =========================================
"     FZF Goodness
"  =========================================

if(s:uname == "Linux\n")
  Plug '~/.fzf'
else
  Plug '/usr/local/opt/fzf'
endif

Plug 'junegunn/fzf.vim'
  nnoremap <leader>g :GFiles<Cr>

"  =========================================
"     Denite
"  =========================================

Plug 'Shougo/denite.nvim'
Plug 'chemzqm/denite-git'


"  =========================================
"     Language agnostic
"  =========================================

Plug 'tpope/vim-surround'

Plug 'w0rp/ale'
  if(s:uname == "Linux\n")
    let g:ale_linters_explicit = 1
  endif
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_fix_on_save = 0
  let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescript.tsx': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \ 'less': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'python': ['yapf']
      \ }

  let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescript.tsx': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint']
      \ }

  let g:ale_typescript_tslint_use_global = 0

Plug 'prettier/vim-prettier', { 'do': 'npm install' }
  let g:prettier#config#semi = 'true'
  let g:prettier#config#jsx_bracket_same_line = 'false'
  let g:prettier#config#bracket_spacing = 'true'
  let g:prettier#config#bracket_spacing = 'true' 
  let g:prettier#config#single_quote = 'true' 

  let g:prettier#exec_cmd_async = 1
  let g:prettier#config#parser = 'typescript'

"  =========================================
"     External tools intergration plugins
"  =========================================
Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'sheerun/vim-polyglot'

Plug 'roman/golden-ratio'

Plug 'itchyny/lightline.vim'

Plug 'maximbaz/lightline-ale'

Plug 'mgee/lightline-bufferline'
  nmap <Leader>1 <Plug>lightline#bufferline#go(1)
  nmap <Leader>2 <Plug>lightline#bufferline#go(2)
  nmap <Leader>3 <Plug>lightline#bufferline#go(3)
  nmap <Leader>4 <Plug>lightline#bufferline#go(4)
  nmap <Leader>5 <Plug>lightline#bufferline#go(5)
  nmap <Leader>6 <Plug>lightline#bufferline#go(6)
  nmap <Leader>7 <Plug>lightline#bufferline#go(7)
  nmap <Leader>8 <Plug>lightline#bufferline#go(8)
  nmap <Leader>9 <Plug>lightline#bufferline#go(9)
  nmap <Leader>0 <Plug>lightline#bufferline#go(10)
