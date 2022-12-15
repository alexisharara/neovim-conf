local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

require('bufferline').setup {
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
}
