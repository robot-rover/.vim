-- Leave Terminal with ESC
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Leave insert mode with Alt-k
vim.keymap.set("i", "<A-k>", "<Esc>")
-- Insertmode ctrl backspace
vim.keymap.set("i", "<C-BS>", "<C-W>")

--  Navigate in Terminal Mode
vim.keymap.set('t', '<C-h>', '<Left>')
vim.keymap.set('t', '<C-n>', '<Down>')
vim.keymap.set('t', '<C-e>', '<Up>')
vim.keymap.set('t', '<TAB>', '<Right>')

--  Alt to move windows in any mode
vim.keymap.set('t', '<A-h>', [[<C-\><C-N><C-w>h]])
vim.keymap.set('t', '<A-n>', [[<C-\><C-N><C-w>j]])
vim.keymap.set('t', '<A-e>', [[<C-\><C-N><C-w>k]])
vim.keymap.set('t', '<A-i>', [[<C-\><C-N><C-w>l]])
vim.keymap.set('i', '<A-h>', [[<C-\><C-N><C-w>h]])
vim.keymap.set('i', '<A-n>', [[<C-\><C-N><C-w>j]])
vim.keymap.set('i', '<A-e>', [[<C-\><C-N><C-w>k]])
vim.keymap.set('i', '<A-i>', [[<C-\><C-N><C-w>l]])
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-n>', '<C-w>j')
vim.keymap.set('n', '<A-e>', '<C-w>k')
vim.keymap.set('n', '<A-i>', '<C-w>l')

-- Move between Folds
vim.keymap.set('n', 'zn', 'zj')
vim.keymap.set('n', 'ze', 'zk')

--  Navigate Menus
-- vim.keymap.set('i', '<C-n>', '<C-n>')
vim.keymap.set('i', '<C-e>', '<C-p>')
-- vim.keymap.set('i', '<a-t>', '<c-x><c-o>')

-- Keys I can still canibalize
-- <C-y>: Scroll up one line
-- Q: Ex mode (nevermind, this is Git now)
-- ?: Reverse find (just use N vs n)
-- [ and ]: Unused
