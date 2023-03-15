local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
--    "lukas-reineke/cmp-rg",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    --    "github/copilot.nvim",
    "zbirenbaum/copilot.lua",
    { "zbirenbaum/copilot-cmp", after = { "copilot.lua" } },
    { "tzachar/cmp-tabnine", build = "./install.sh" },
  },

  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local tabnine = require("cmp_tabnine.config")
    local copilot = require("copilot")
    local cmp_copilot = require("copilot_cmp")

   lspkind.init({ symbol_map = { copilot = "", }, })

    tabnine:setup({
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
      show_prediction_strength = true,
    })

    copilot.setup({
            filetypes = {
                javascript = true,
                clojure = true,
                go = true,
                python = true,
                typescript = true,
            },
        suggestion = { enabled = true },
      panel = { enabled = false },
    })

    cmp_copilot.setup({})
    local source_mapping = {
            buffer = "[Buf]",
            rg = "[Rip]",
            nvim_lsp = "[lsp]",
            cmp_tabnine = "[T9]",
            cmp_copilot = "[Gh]",
            path = "[Path]",
            luasnip = "[Snip]",
            calc = "[Calc]",
          }

    cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			-- if you have lspkind installed, you can use it like
			-- in the following line:
	 		vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
	 		vim_item.menu = source_mapping[entry.source.name]
	 		if entry.source.name == "cmp_tabnine" then
	 			local detail = (entry.completion_item.data or {}).detail
	 			vim_item.kind = ""
	 			if detail and detail:find('.*%%.*') then
	 				vim_item.kind = vim_item.kind .. ' ' .. detail
	 			end

	 			if (entry.completion_item.data or {}).multiline then
	 				vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
	 			end
	 		end
	 		local maxwidth = 80
	 		vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
	 		return vim_item
	  end,
	},
        snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "cmp_tabnine" },
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "copilot" },
        { name = "buffer", keyword_length = 5 },
        { name = "luasnip" },
        { name = "calc" },
        { name = "path" },
        { name = "rg", keyword_length = 5 },
        -- { omni = true }, -- completion for vimtex - is this necessary?
      },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}

return M
