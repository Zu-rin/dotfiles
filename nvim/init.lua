vim.api.nvim_set_var('dein#auto_recache', 1)
vim.api.nvim_set_var('dein#lazy_rplugins', 1)
vim.api.nvim_set_var('dein#enable_notification', 1)
vim.api.nvim_set_var('dein#install_max_processes', 16)
vim.api.nvim_set_var('dein#install_message_type', 'none')
vim.api.nvim_set_var('dein#enable_notification', 1)

local dein_dir = vim.env.HOME .. '/dotfiles/.vim/dein'
local dein_repo_dir = dein_dir .. '/repos/github.com/Shougo/dein.vim'

if not string.match(vim.o.runtimepath, '/dein.vim') then
    if vim.fn.isdirectory(dein_repo_dir) ~= 1 then
        os.execute('git clone https://github.com/Shougo/dein.vim '..dein_repo_dir)
    end
    vim.o.runtimepath = dein_repo_dir .. ',' .. vim.o.runtimepath 
end

if vim.call('dein#load_state', dein_dir) == 1 then
    local dein_toml = vim.env.HOME .. '/dotfiles/nvim/dein.toml'
    local dein_toml_lazy = vim.env.HOME .. '/dotfiles/nvim/lazy.toml'
    local dein_share_toml = dein_dir .. '/share.toml'

    vim.call('dein#begin', dein_dir, {vim.fn.expand('<sfile>'), dein_toml, dein_toml_lazy, dein_toml_input})

    vim.call('dein#load_toml', dein_toml, {lazy = 0})
    vim.call('dein#load_toml', dein_toml_lazy, {lazy = 1})
    vim.call('dein#load_toml', dein_share_toml, {lazy = 0})

    vim.call('dein#end')
    vim.call('dein#save_state')
end

if vim.call('dein#check_install') == 1 then
    vim.call('dein#install')
end

require('settings')
require('maps')

