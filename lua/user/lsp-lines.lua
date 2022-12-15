vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
        vim.diagnostic.config({virtual_lines = false})
    end,
})
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = 'i:*',
    callback = function()
        vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    end,
})
