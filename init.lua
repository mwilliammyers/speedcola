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
  install_npm_pkg('typescript', 'typescript-language-server')
  if vim.fn.executable('rustup') == 1 then
    vim.fn.system('rustup component add rust-analyzer 2>/dev/null')
  end
end

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

now(function()
  add('navarasu/onedark.nvim')
  local ok, onedark = pcall(require, 'onedark')
  if ok then
    onedark.setup({ style = 'dark' })
    onedark.load()
  end

  add('nvim-mini/mini.statusline')
  local ok, statusline = pcall(require, 'mini.statusline')
  if ok then statusline.setup() end

  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = { post_checkout = function() install_system_deps(); vim.cmd('TSUpdate') end },
  })
  local ok, ts = pcall(require, 'nvim-treesitter.configs')
  if ok then
    ts.setup({
      ensure_installed = { 'python', 'rust', 'typescript', 'javascript' },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end

  -- blink.cmp must load before lspconfig (LSP uses blink capabilities)
  add({ source = 'saghen/blink.cmp', checkout = 'v1.3.1' })
  local ok, blink = pcall(require, 'blink.cmp')
  if ok then
    blink.setup({
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
  end

  add('neovim/nvim-lspconfig')
  local capabilities = { general = { positionEncodings = { 'utf-16' } } }
  local ok, blink = pcall(require, 'blink.cmp')
  if ok then capabilities = blink.get_lsp_capabilities(capabilities) end
  vim.lsp.config('*', { capabilities = capabilities })
  vim.lsp.enable({ 'ruff', 'ty', 'ts_ls', 'rust_analyzer' })

  add('junegunn/fzf')
  add('junegunn/fzf.vim')
end)

later(function()
  add('folke/flash.nvim')
  local ok, flash = pcall(require, 'flash')
  if ok then
    flash.setup({})
    vim.keymap.set({ 'n', 'x', 'o' }, 's', flash.jump)
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', flash.treesitter)
  end

  add('lewis6991/gitsigns.nvim')
  add('tpope/vim-fugitive')
  local ok, gitsigns = pcall(require, 'gitsigns')
  if ok then
    gitsigns.setup({
      on_attach = function(buf)
        local gs = gitsigns
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
  end

  add('nvim-mini/mini.surround')
  local ok, surround = pcall(require, 'mini.surround')
  if ok then surround.setup() end

  add('folke/trouble.nvim')
  local ok, trouble = pcall(require, 'trouble')
  if ok then trouble.setup() end
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
map('n', '<Leader>vt', ':vsplit term://$SHELL<CR>')
map('n', '<Leader>xt', ':split term://$SHELL<CR>')

-- FZF
map('n', '<C-p>', ':Files<CR>', { silent = true })
map('n', '<C-S-p>', ':Commands<CR>', { silent = true })
map('n', '<C-f>', ':Rg<CR>', { silent = true })
map('n', '<Leader>rg', ':Rg<CR>', { silent = true })
map('n', '<Leader>/', ':Rg<CR>', { silent = true })
map('n', '<Leader>b', ':Buffers<CR>', { silent = true })
map('n', '<Leader><Enter>', ':Buffers<CR>', { silent = true })
map('n', '<Leader>l', ':Lines<CR>', { silent = true })
map('n', '<Leader>h', ':Helptags<CR>', { silent = true })
map('n', '<Leader>;', ':Commands<CR>', { silent = true })
map('n', '<Leader>m', ':Maps<CR>', { silent = true })
map('n', '<Leader>c', ':Commits<CR>', { silent = true })
map('n', '<Leader>q', ':History<CR>', { silent = true })

-- Fugitive
map('n', '<Leader>Gs', ':Git<CR>', { silent = true })
map('n', '<Leader>Gd', ':Gdiff<CR>', { silent = true })
map('n', '<Leader>Gb', ':Git blame<CR>', { silent = true })
map('n', '<Leader>Gp', ':Git push<CR>', { silent = true })

-- Diagnostics
map('n', '<space>e', vim.diagnostic.open_float)
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<space>q', ':Trouble diagnostics<CR>', { silent = true })

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
    map('n', '<space>D', vim.lsp.buf.type_definition, opts)
    map('n', '<space>rn', vim.lsp.buf.rename, opts)
    map('n', '<space>ca', vim.lsp.buf.code_action, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<Leader>f', function()
      vim.lsp.buf.format({
        async = true,
        filter = function(client)
          -- Use ruff for Python, let others use their default
          if vim.bo.filetype == 'python' then
            return client.name == 'ruff'
          end
          return true
        end,
      })
    end, opts)
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

-- Python colorcolumn
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'python',
  callback = function()
    vim.opt_local.colorcolumn = '79,88'
  end,
})

-- Format Python on save (via ruff)
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.format({
      async = false,
      filter = function(client) return client.name == 'ruff' end,
    })
  end,
})

-- Open fzf if no file specified
vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd('Files')
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
