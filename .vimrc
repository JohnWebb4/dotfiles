let s:uname = system("uname -s")

if (s:uname == "Linux")
  set clipboard+=unnamedplus
else
  set clipboard=unnamed
endif

autocmd Filetype gitcommit setlocal spell textwidth=72
