-- Add any additional keymaps here
local opts = {
    noremap = true,
    silent = true
}

local term_opts = {
    silent = true
}

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- better up/down
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true,
    noremap = true
})
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true,
    noremap = true
})

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", {
    desc = "Prev buffer"
})
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", {
    desc = "Next buffer"
})
keymap("n", "[b", "<cmd>BufferLineCyclePrev<cr>", {
    desc = "Prev buffer"
})
keymap("n", "]b", "<cmd>BufferLineCycleNext<cr>", {
    desc = "Next buffer"
})

-- Clear search with <esc>
keymap("n", "<ESC>", "<cmd>noh<cr><ESC>", {
    noremap = true,
    desc = "Escape and clear hlsearch"
})
keymap("i", "<ESC>", "<cmd>noh<cr><ESC>", {
    noremap = true,
    desc = "Escape and clear hlsearch"
})

keymap("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", {
    noremap = true,
    desc = "Redraw / clear hlsearch / diff update"
})

keymap("n", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result",
    noremap = true
})
keymap("x", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result",
    noremap = true
})
keymap("o", "n", "'Nn'[v:searchforward]", {
    expr = true,
    desc = "Next search result",
    noremap = true
})
keymap("n", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result",
    noremap = true
})
keymap("x", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result",
    noremap = true
})
keymap("o", "N", "'nN'[v:searchforward]", {
    expr = true,
    desc = "Prev search result",
    noremap = true
})

-- save file
keymap("i", "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})
keymap("v", "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})
keymap("n", "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})
keymap("s", "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})
keymap("x", "<C-s>", "<cmd>w<cr><esc>", {
    desc = "Save file"
})

-- lazy
keymap("n", "<leader>l", "<cmd>:Lazy<cr>", {
    desc = "Lazy"
})

-- new file
keymap("n", "<leader>fn", "<cmd>enew<cr>", {
    desc = "New File"
})

keymap("n", "<leader>xl", "<cmd>lopen<cr>", {
    desc = "Location List"
})
keymap("n", "<leader>xq", "<cmd>copen<cr>", {
    desc = "Quickfix List"
})

-- quit
keymap("n", "<leader>Q", "<cmd>qa<cr>", {
    desc = "Quit all"
})

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
