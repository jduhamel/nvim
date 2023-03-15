
local M = {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-web-devicons",
    event = "BufReadPre",
}

function M.config()
    local g_ok, bufferline_groups = pcall(require, "bufferline.groups")
    if not g_ok then
        bufferline_groups = {
            builtin = {
                pinned = {
                    name = "pinned",
                    with = function(_ico) end,
                },
                ungroupued = { name = "ungrouped" },
            },
        }
    end

    require("bufferline").setup({
            options = {
                separator_style = "slant",
                diagnostics = "nvim_lsp",
                numbers = "none",
                sort_by = "insert_after_current",
                groups = {
                    options = {
                        toggle_hidden_on_enter = true,
                    },
                    items = {
                        bufferline_groups.builtin.pinned:with { icon = "" },
                        bufferline_groups.builtin.ungrouped,
                        {
                            name = "Internals",
                            highlight = { fg = "#ECBE7B" },
                            matcher = function(buf)
                                local dpath = vim.fn.stdpath("data")
                                return vim.startswith(buf.path, vim.env.VIMRUNTIME) or vim.startswith(buf.path, dpath)
                            end,
                        },
                        {
                            highlight = { sp = "#51AFEF" },
                            name = "Tests",
                            icon = "✅",
                            matcher = function(buf)
                                local name = buf.filename
                                return name:match "_spec" or name:match "_test" or name:match "test_"
                            end,
                        },
                        {
                            name = "Terraform",
                            matcher = function(buf)
                                return buf.name:match "%.tf" ~= nil
                            end,
                        },
                        {
                            name = "SQL",
                            matcher = function(buf)
                                return buf.filename:match "%.sql$"
                            end,
                        },
                        {
                            name = "View models",
                            highlight = { sp = "#03589C" },
                            matcher = function(buf)
                                return buf.filename:match "view_model%.dart"
                            end,
                        },
                        {
                            name = "Screens",
                            icon = '󰹑 ',
                            matcher = function(buf)
                                return buf.path:match "screen"
                            end,
                        },
                        {
                            highlight = { sp = "#C678DD" },
                            name = "Docs",
                            matcher = function(buf)
                                for _, ext in ipairs { "md", "txt", "org", "norg", "wiki" } do
                                    if ext == vim.fn.fnamemodify(buf.path, ":e") then
                                        return true
                                    end
                                end
                            end,
                        },
                        {
                            highlight = { sp = "#F6A878" },
                            name = "Config",
                            matcher = function(buf)
                                local filename = buf.filename
                                if filename == nil then
                                    return false
                                end
                                return filename:match "go.mod"
                                    or filename:match "go.sum"
                                    or filename:match "Cargo.toml"
                                    or filename:match "manage.py"
                                    or filename:match "Makefile"
                            end,
                        },
                        {
                            name = "Terms",
                            auto_close = true,
                            matcher = function(buf)
                                return buf.path:match "term://" ~= nil
                            end,
                        },
                    },
                },
                hover = { enabled = true, reveal = { "close" } },
                offsets = {
                    {
                        text = "EXPLORER",
                        filetype = "neo-tree",
                        highlight = "PanelHeading",
                        text_align = "left",
                        separator = true,
                    },
                    {
                        text = " FLUTTER OUTLINE",
                        filetype = "flutterToolsOutline",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                    {
                        text = "UNDOTREE",
                        filetype = "undotree",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                    {
                        text = " LAZY",
                        filetype = "lazy",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                    {
                        text = " DATABASE VIEWER",
                        filetype = "dbui",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                    {
                        text = " DIFF VIEW",
                        filetype = "DiffviewFiles",
                        highlight = "PanelHeading",
                        separator = true,
                    },
                },
                right_mouse_command = "vert sbuffer %d",
                show_close_icon = false,
                -- indicator = { style = "bold" },
                indicator = {
                    icon = "▎", -- this should be omitted if indicator style is not 'icon'
                    style = "icon", -- can also be 'underline'|'none',
                },
                max_name_length = 18,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                truncate_names = true, -- whether or not tab names should be truncated
                tab_size = 18,
                color_icons = true,
                show_buffer_close_icons = true,
                diagnostics_update_in_insert = false,
            }
  })
end

return M
