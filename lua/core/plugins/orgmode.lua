local M = {
  "nvim-orgmode/orgmode",
  dependecies = { "lvim-tech/lvim-org-utils" },
  ft = { "org" },
  config = function()
    local status_ok, org_mode = pcall(require, "orgmode")
    if not status_ok then
      vim.notify("Org mode failed loading")
      return
    end

    org_mode.setup_ts_grammar()
    org_mode.setup({
      org_agenda_files = { "~/sorgs/**/*" },
      org_default_notes_file = "~/orgs/refile.org",

      -- org_agenda_templates = {
      --   T = {
      --     description = "Todo",
      --     template = "* TODO %?\n  DEADLINE: %T",
      --     target = "~/shared/orgs/todos.org",
      --   },
      --   w = {
      --     description = "Work todo",
      --     template = "* TODO %?\n  DEADLINE: %T",
      --     target = "~/shared/orgs/work.org",
      --   },
      -- },
      mappings = {
        global = {
          org_agenda = "go",
          org_capture = "gC",
        },
      },
    })

    local l_status_ok, lvim_org_utils = pcall(require, "lvim-org-utils")
    if not l_status_ok then
      vim.notify("Error loading lvim-org-utils")
    end

    lvim_org_utils.setup(nil)
  end,
}

return M
