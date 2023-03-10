-- TODO: alternative: https://github.com/Wansmer/treesj
local M = {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
}

function M.config()
  local chatgpt = require("chatgpt")
  chatgpt.setup()
end

return M
