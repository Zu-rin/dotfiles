local map = vim.api.nvim_set_keymap

local opts = { noremap = true }

map('n', '<S-Tab>', '<<', opts)
map('i', '<S-Tab>', '<C-o><<', opts)

map('i', '<S-Left>', '<C-o>0', opts)
map('i', '<S-Right>', '<C-o>$', opts)
--map('i', '<ESC>', '<ESC>:w<CR>', opts)

-- Fern
map('n', '<C-]>', ':Fern . -reveal=% -drawer -toggle -width=30<CR>', opts)
map('i', '<C-]>', '<C-o>:Fern . -reveal=% -drawer -toggle -width=30<CR>', opts)

-- Telescope
--
map('n', '<C-f>', ':Telescope find_files hidden=true theme=get_dropdown<CR>', opts)
map('i', '<C-f>', '<ESC>:Telescope find_files hidden=true theme=get_dropdown<CR>', opts)

map('n', '<C-g>', ':Telescope live_grep theme=get_dropdown<CR>', opts)
map('i', '<C-g>', '<ESC>:Telescope live_grep theme=get_dropdown<CR>', opts)

