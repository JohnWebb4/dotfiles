-- Using fd (highly recommended for fzf)
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,target,build,snapshots,Pods,target,tmp}"'

vim.api.nvim_create_user_command('Ag', function(opts)
  -- Add folders to ignore here (e.g., node_modules, target, build)
  local ignore_flags = '--ignore ".git" --ignore "node_modules" --ignore "target" --ignore "build" --ignore "snapshots" --ignore "Pods" --ignore "target" --ignore "tmp"'
  
  -- Combine flags with the user's search query
  local query = ignore_flags .. ' ' .. vim.fn.shellescape(opts.args)
  
  -- Call the fzf.vim raw ag function
  vim.fn['fzf#vim#ag_raw'](query, 0)
end, { nargs = '+' })
