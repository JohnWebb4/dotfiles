" let g:node_host_prog = '/Users/dan.loudon/.nvm/versions/node/v8.3.0/bin/neovim-node-host'

call deoplete#custom#buffer_option('auto_complete', v:false)

call deoplete#custom#source('_',
  \ 'disabled_syntaxes', ['Comment', 'String'])

call deoplete#custom#source('jedi',
      \ 'filetypes', ['python', 'python3'])

call deoplete#custom#source('ternjs',
      \ 'filetypes', ['javascript', 'javascript.jsx'])

call deoplete#custom#source('typescript',
      \ 'filetypes', [
      \ 'typescript',
      \ 'typescriptreact',
      \ 'typescript.tsx',
      \ 'javascript',
      \ 'javascript.jsx'
      \ ])

let g:LanguageClient_waitOutputTimeout = 30

let g:LanguageClient_serverCommands = {}

if executable('pyls')
  let g:LanguageClient_serverCommands.python = ['pyls']

  autocmd FileType python setlocal formatprg=yapf
  autocmd FileType python setlocal shiftwidth=4
endif

if executable('javascript-typescript-langserver')
  let g:LanguageClient_serverCommands = {
        \ 'typescript': ['~/.nvm/versions/node/v8.9.0/bin/javascript-typescript-stdio'],
        \ 'typescriptreact': ['~/.nvm/versions/node/v8.9.0/bin/javascript-typescript-stdio'],
        \ 'typescript.tsx': ['~/.nvm/versions/node/v8.9.0/bin/javascript-typescript-stdio'],
        \ 'javascript.jsx': ['~/.nvm/versions/node/v8.9.0/bin/javascript-typescript-stdio'],
        \ 'javascript': ['~/.nvm/versions/node/v8.9.0/bin/javascript-typescript-stdio']
        \ }

  autocmd FileType javascript,javascript.jsx,typescriptreact,typescript.tsx,typescript setlocal omnifunc=tern#Complete
endif

nnoremap <leader>ld :call LanguageClient_textDocument_definition()<cr>
nnoremap <leader>lh :call LanguageClient_textDocument_hover()<cr>
nnoremap <leader>lr :call LanguageClient_textDocument_rename()<cr>
nnoremap <leader>lf :call LanguageClient_textDocument_codeAction()<cr>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<cr>

" autocmd FileType javascript,python,typescriptreact,typescript.tsx,typescript nnoremap <buffer>
"       \ <leader>ld :call LanguageClient_textDocument_definition()<cr>
" autocmd FileType javascript,python,typescriptreact,typescript.tsx,typescript nnoremap <buffer>
"       \ <leader>lh :call LanguageClient_textDocument_hover()<cr>
" autocmd FileType javascript,python,typescriptreact,typescript.tsx,typescript nnoremap <buffer>
"       \ <leader>lr :call LanguageClient_textDocument_rename()<cr>
" autocmd FileType javascript,python,typescriptreact,typescript.tsx,typescript nnoremap <buffer>
"       \ <leader>lf :call LanguageClient_textDocument_codeAction()<cr>
