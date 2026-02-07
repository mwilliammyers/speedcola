-- speedcola neovim configuration
-- https://github.com/mwilliammyers/speedcola

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------
vim.g.mapleader = ','

vim.opt.modeline = false
vim.opt.undofile = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.shortmess:append 'c'
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.belloff = 'all'
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.colorcolumn = '80,100'
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.inccommand = 'split'
vim.opt.timeoutlen = 300
vim.opt.updatetime = 500
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevelstart = 99
vim.g.sql_type_default = 'pgsql'
vim.opt.wildmode = 'list:longest,full'
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'
vim.opt.wildignore:append {
  '.git', 'node_modules', 'target',
  '*.pyc', '__pycache__', '*.egg-info', '.venv', 'venv',
  '*.o', '*.so', '*.rlib',
  'dist', 'build', '.next',
  '.DS_Store',
}

--------------------------------------------------------------------------------
-- mini.deps bootstrap
--------------------------------------------------------------------------------
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.deps'
if not vim.uv.fs_stat(mini_path) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.deps',
    mini_path,
  })
  vim.cmd('packadd mini.deps | helptags ALL')
end
require('mini.deps').setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

local function setup(name, opts, callback)
  local ok, mod = pcall(require, name)
  if ok then
    if opts ~= false then mod.setup(opts or {}) end
    if callback then callback(mod) end
    return mod
  end
end

local function install_sys_pkg(...)
  local pkgs = { ... }
  local cmd
  if vim.fn.executable('brew') == 1 then
    cmd = 'brew install'
  elseif vim.fn.executable('apt-get') == 1 then
    cmd = 'sudo apt-get install -y'
  elseif vim.fn.executable('pacman') == 1 then
    cmd = 'sudo pacman -S --noconfirm'
  else
    return
  end
  vim.fn.system(cmd .. ' ' .. table.concat(pkgs, ' ') .. ' 2>/dev/null')
end

local function install_python_pkg(...)
  local pkgs = { ... }
  if vim.fn.executable('uv') == 1 then
    for _, pkg in ipairs(pkgs) do
      vim.fn.system('uv tool install ' .. pkg .. ' 2>/dev/null')
    end
  elseif vim.fn.executable('pip') == 1 then
    vim.fn.system('pip install ' .. table.concat(pkgs, ' ') .. ' 2>/dev/null')
  elseif vim.fn.executable('pip3') == 1 then
    vim.fn.system('pip3 install ' .. table.concat(pkgs, ' ') .. ' 2>/dev/null')
  end
end

local function install_npm_pkg(...)
  if vim.fn.executable('npm') == 1 then
    vim.fn.system('npm install -g ' .. table.concat({ ... }, ' ') .. ' 2>/dev/null')
  end
end

-- Install system dependencies (runs once on first plugin install)
local function install_system_deps()
  install_sys_pkg('ripgrep', 'fzf', 'tree-sitter-cli')
  install_python_pkg('ruff', 'ty')
  install_npm_pkg('typescript', 'typescript-language-server', 'prettier')
  if vim.fn.executable('rustup') == 1 then
    vim.fn.system('rustup component add rust-analyzer 2>/dev/null')
  end
end

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

now(function()
  add('navarasu/onedark.nvim')
  setup('onedark', { style = 'dark' }, function(m) m.load() end)

  add('nvim-mini/mini.statusline')
  setup('mini.statusline')

  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() install_system_deps(); vim.cmd('TSUpdate') end },
  })
  setup('nvim-treesitter.configs', {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })

  -- blink.cmp must load before lspconfig (LSP uses blink capabilities)
  add({ source = 'saghen/blink.cmp', checkout = 'v1.3.1' })
  setup('blink.cmp', {
    keymap = {
      ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-Space>'] = { 'show' },
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = true } },
    },
    signature = { enabled = true },
    sources = { default = { 'lsp', 'snippets', 'path', 'buffer' } },
    cmdline = {
      sources = function()
        local type = vim.fn.getcmdtype()
        if type == '/' or type == '?' then return { 'buffer' } end
        if type == ':' then return { 'cmdline' } end
        return {}
      end,
    },
    fuzzy = { sorts = { 'exact', 'score', 'sort_text' } },
  })

  add('neovim/nvim-lspconfig')
  local capabilities = { general = { positionEncodings = { 'utf-16' } } }
  local ok, blink = pcall(require, 'blink.cmp')
  if ok then capabilities = blink.get_lsp_capabilities(capabilities) end
  vim.lsp.config('*', { capabilities = capabilities })
  vim.lsp.enable({ 'ruff', 'ty', 'ts_ls', 'rust_analyzer' })

  add('ibhagwan/fzf-lua')
  require('fzf-lua').setup({
    winopts = {
      height = 0.85,
      width = 0.80,
    },
    fzf_opts = {
      ['--no-exact'] = '',  -- Enable fuzzy matching by default
    },
    lsp = {
      symbols = {
        async_or_timeout = true,  -- Use live query for workspace symbols
      },
    },
  })
end)

later(function()
  add('folke/flash.nvim')
  setup('flash', {}, function(flash)
    vim.keymap.set({ 'n', 'x', 'o' }, 's', flash.jump)
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', flash.treesitter)
  end)

  add('lewis6991/gitsigns.nvim')
  setup('gitsigns', {
    on_attach = function(buf)
      local gs = package.loaded.gitsigns
      local map = function(l, r, desc) vim.keymap.set('n', l, r, { buffer = buf, desc = desc }) end
      map(']h', gs.next_hunk, 'Next hunk')
      map('[h', gs.prev_hunk, 'Prev hunk')
      map('<leader>hs', gs.stage_hunk, 'Stage hunk')
      map('<leader>hr', gs.reset_hunk, 'Reset hunk')
      map('<leader>hp', gs.preview_hunk, 'Preview hunk')
      map('<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame line')
      map('<leader>hd', gs.diffthis, 'Diff this')
    end,
  })

  add('nvim-mini/mini.surround')
  setup('mini.surround')

  add('folke/trouble.nvim')
  setup('trouble', { open_no_results = true })

  add('mhartington/formatter.nvim')
  setup('formatter', {
    filetype = {
      python = { require('formatter.filetypes.python').ruff },
      rust = { require('formatter.filetypes.rust').rustfmt },
      javascript = { require('formatter.filetypes.javascript').prettier },
      typescript = { require('formatter.filetypes.typescript').prettier },
      json = { require('formatter.filetypes.json').prettier },
      ['*'] = { require('formatter.filetypes.any').remove_trailing_whitespace },
    },
  })

  add('folke/which-key.nvim')
  setup('which-key')
end)

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------
local map = vim.keymap.set

-- General
-- see also the autocommand below
map('n', '<Esc>', function()
  vim.cmd('nohlsearch')
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      pcall(vim.api.nvim_win_close, win, false)
    end
  end
end, { silent = true })

-- Terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<Leader>vt', ':vsplit term://$SHELL<CR>', { desc = 'Vertical terminal' })
map('n', '<Leader>xt', ':split term://$SHELL<CR>', { desc = 'Horizontal terminal' })

-- Window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- FZF-Lua
local fzf = require('fzf-lua')
map('n', '<C-p>', fzf.files, { silent = true, desc = 'Find files' })
map('n', '<C-S-p>', fzf.commands, { silent = true, desc = 'Commands' })
map('n', '<Leader>rg', fzf.live_grep, { silent = true, desc = 'Live grep' })
map('n', '<Leader>/', fzf.live_grep, { silent = true, desc = 'Live grep' })
map('n', '<Leader>b', fzf.buffers, { silent = true, desc = 'Buffers' })
map('n', '<Leader><Enter>', fzf.buffers, { silent = true, desc = 'Buffers' })
map('n', '<Leader>l', fzf.lines, { silent = true, desc = 'Lines' })
map('n', '<Leader>h', fzf.helptags, { silent = true, desc = 'Help tags' })
map('n', '<Leader>;', fzf.commands, { silent = true, desc = 'Commands' })
map('n', '<Leader>m', fzf.keymaps, { silent = true, desc = 'Keymaps' })
map('n', '<Leader>c', fzf.git_commits, { silent = true, desc = 'Git commits' })
map('n', '<Leader>q', fzf.command_history, { silent = true, desc = 'Command history' })

-- Format
map('n', '<Leader>f', ':Format<CR>', { silent = true, desc = 'Format' })

-- Diagnostics
map('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Diagnostics float' })
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<Leader>t', '<cmd>Trouble diagnostics toggle<cr>', { silent = true, desc = 'Toggle trouble' })

--------------------------------------------------------------------------------
-- LSP Keymaps
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local buf = args.buf
    local opts = { buffer = buf }
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'K', vim.lsp.buf.hover, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<Leader>D', vim.lsp.buf.type_definition, { buffer = buf, desc = 'Type definition' })
    map('n', '<Leader>rn', vim.lsp.buf.rename, { buffer = buf, desc = 'Rename' })
    map('n', '<Leader>ca', vim.lsp.buf.code_action, { buffer = buf, desc = 'Code action' })
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<C-t>', fzf.lsp_live_workspace_symbols, opts)
  end,
})

--------------------------------------------------------------------------------
-- Autocommands
--------------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- Check for file changes on focus
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  group = augroup,
  callback = function()
    if vim.fn.mode() ~= 'c' then vim.cmd('checktime') end
  end,
})

-- Colorcolumn
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  callback = function()
    vim.opt_local.colorcolumn = '79,99'
  end,
})

-- Format Python on save (via formatter.nvim)
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup,
  pattern = '*.py',
  command = 'FormatWrite',
})

-- Open fzf if no file specified
vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup,
  callback = function()
    if vim.fn.argc() == 0 then
      require('fzf-lua').files()
    end
  end,
})

-- Esc closes quickfix, help, fzf, trouble windows
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'qf', 'help', 'fzf', 'trouble' },
  callback = function()
    vim.keymap.set('n', '<Esc>', ':close<CR>', { buffer = true, silent = true })
  end,
})

-- Show diagnostics on cursor hold
vim.api.nvim_create_autocmd('CursorHold', {
  group = augroup,
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150 })
  end,
})
