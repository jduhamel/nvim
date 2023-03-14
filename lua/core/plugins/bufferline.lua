
local M = {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-web-devicons",
    event = "BufReadPre",
}

function M.config()
    require("bufferline").setup({
    options = {
            offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        numbers = "none"
    }
})
end

return M
