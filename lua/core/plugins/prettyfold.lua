local M = {
  "anuvyklack/pretty-fold.nvim",
  dependencies = { "anuvyklack/fold-preview.nvim" },
  config = function()
    local status_ok, pretty_fold = pcall(require, "pretty-fold")
    if not status_ok then
      vim.notify("Error loading pretty-fold")
      return
    end

    pretty_fold.setup({
      fill_char = "─",
      sections = {
        left = {
          "content",
        },
        right = {
          "┤ ",
          "number_of_folded_lines",
          " ├─",
        },
      },
      ft_ignore = { "org" },
    })
    local fold_preview_status_ok, fold_preview = pcall(require, "fold-preview")
    if not fold_preview_status_ok then
      return
    end
    fold_preview.setup({
      default_keybindings = false,
    })
    local map = require("fold-preview").mapping
    function _G.fold_preview()
      map.show_close_preview_open_fold()
      vim.cmd("IndentBlanklineRefresh")
    end
    vim.api.nvim_create_user_command("FoldPreview", "lua _G.fold_preview()", {})
    vim.keymap.set("n", "zp", function()
      _G.fold_preview()
    end, { noremap = true, silent = true, desc = "FoldPreview" })
  end,
}

return M
