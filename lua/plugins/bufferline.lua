return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
        options = {
            numbers = "none",
            indicator = {
                style = 'icon'
            },
            diagnostic = "nvim_lsp",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true
                }
            }
        }
    },
}
