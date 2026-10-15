-- Ignore list shared with .zshrc and powershell/Profile.ps1: ../fzf-ignore.txt
local function ignore_dirs()
  local dirs = {}
  local path = vim.fn.stdpath('config') .. '/fzf-ignore.txt'
  for _, line in ipairs(vim.fn.filereadable(path) == 1 and vim.fn.readfile(path) or {}) do
    if line:match('%S') then table.insert(dirs, vim.trim(line)) end
  end
  return dirs
end

local dirs = ignore_dirs()

-- Double quotes work in both cmd.exe (fzf's default shell on Windows) and sh
vim.env.FZF_DEFAULT_COMMAND =
  'rg --files --no-ignore --hidden --follow -g "!{' .. table.concat(dirs, ',') .. '}"'

vim.api.nvim_create_user_command('Ag', function(opts)
  local flags = {}
  for _, d in ipairs(dirs) do table.insert(flags, '--ignore "' .. d .. '"') end

  -- Combine flags with the user's search query
  local query = table.concat(flags, ' ') .. ' ' .. vim.fn.shellescape(opts.args)

  -- Call the fzf.vim raw ag function
  vim.fn['fzf#vim#ag_raw'](query, 0)
end, { nargs = '+' })
