"  =========================================
"     Dependencies
"  =========================================
Plug 'tpope/vim-repeat'

"  =========================================
"    Config Variables
"  =========================================
let s:uname = system("uname -s")

"  =========================================
"     Colorschemes
"  =========================================
Plug 'nightsense/snow'


"  =========================================
"     FZF Goodness
"  =========================================
if(s:uname == "Linux\n")
  Plug '~/.fzf'
else
  Plug '/usr/local/opt/fzf'
endif

Plug 'junegunn/fzf.vim'
  " nnoremap <leader>f :Files<Cr>
  nnoremap <leader>g :GFiles<Cr>
  " nnoremap <leader>l :Lines<Cr>
  " nnoremap <leader>a :Ag<Cr>

"  =========================================
"     Denite
"  =========================================
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc-denite'

Plug 'Shougo/denite.nvim'
Plug 'chemzqm/denite-git'


"  =========================================
"     Language agnostic
"  =========================================
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'

Plug 'w0rp/ale'
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_fix_on_save = 0
  let g:ale_linters = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'tslint'],
      \ 'typescript.tsx': ['prettier', 'tslint'],
      \ 'typescriptreact': ['prettier', 'tslint'],
      \ 'less': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'python': ['yapf']
      \ }

  let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascript.jsx': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'tslint'],
      \ 'typescript.tsx': ['prettier', 'tslint'],
      \ 'typescriptreact': ['prettier', 'tslint']
      \ }

  let g:ale_typescript_tslint_use_global = 0
  let g:ale_typescript_tslint_executable = 'tslint'
  let g:ale_typescript_tslint_config_path = 'tslint.json'

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

"  =========================================
"     Languages
"  =========================================
Plug 'sheerun/vim-polyglot'

"  =========================================
"     Javascript
"  =========================================
Plug 'pangloss/vim-javascript', { 'for': [
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'typescript',
      \ 'typescrip.tsx',
      \ 'typescriptreact'
      \ ] }

Plug 'vim-scripts/JavaScript-Indent', { 'for': [
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'typescript',
      \ 'typescript.tsx',
      \ 'typescriptreact'
      \ ] }

Plug 'mxw/vim-jsx', { 'for': [
      \ 'javascript',
      \ 'javascript.jsx',
      \ 'typescript',
      \ 'typescript.tsx',
      \ 'typescriptreact'
      \ ] }
  let g:jsx_ext_required = 0

Plug 'HerringtonDarkholme/yats.vim', { 'for': [
      \ 'typescript',
      \ 'typescript.tsx',
      \ 'typescriptreact'
      \ ] }

Plug 'posva/vim-vue'

"  =========================================
"     HTML/CSS
"  =========================================

Plug 'cakebaker/scss-syntax.vim', { 'for': 'sass' }

"  =========================================
"     YAML
"  =========================================
Plug 'mrk21/yaml-vim'

"  =========================================
"     Interface improvement
"  =========================================
Plug 'scrooloose/nerdtree'
  let g:NERDTreeMinimalUI = 1 " not so much cruft
  let g:NERDTreeShowHidden = 1 " Should hidden files
  let g:NERDTreeShowLineNumbers = 1
  let g:NERDTreeIgnore=['\.DS_Store']
  let g:NERDTreeShowBookmarks = 1
  hi def link NERDTreeRO Normal
  hi def link NERDTreePart StatusLine
  hi def link NERDTreeDirSlash Directory
  hi def link NERDTreeCurrentNode Search
  hi def link NERDTreeCWD Normal

Plug 'jistr/vim-nerdtree-tabs'
  nnoremap <leader>d :NERDTreeTabsToggle<CR>
  nnoremap <leader>D :NERDTreeTabsFind<CR>

Plug 'roman/golden-ratio'

Plug 'itchyny/lightline.vim'

Plug 'maximbaz/lightline-ale'

Plug 'JamshedVesuna/vim-markdown-preview'
  let vim_markdown_preview_github=1

Plug 'jiangmiao/auto-pairs'

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

Plug 'arithran/vim-delete-hidden-buffers'
  nnoremap <leader>v :DeleteHiddenBuffers<CR>
