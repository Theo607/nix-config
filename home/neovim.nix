{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nixd clang-tools zig zls
      vscode-langservers-extracted
      typescript-language-server
      phpactor
      haskell-language-server
      ocamlPackages.ocaml-lsp
      swi-prolog
      kotlin-language-server
      jdt-language-server 
      pyright
      gopls
      sbcl
      polyml
      gnat
    ];

    extraLuaConfig = ''
      -- 0. Indent
      -- Indentation
      vim.opt.tabstop = 4        
      vim.opt.shiftwidth = 4    
      vim.opt.softtabstop = 4  
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.autoindent = true
      -- Language specific indentation
      vim.api.nvim_create_autocmd("FileType", {
              pattern = { "lua", "nix", "typescript", "javascript", "html", "css", "json", "yaml", "haskell", "ocaml" },
              callback = function()
              vim.opt_local.tabstop = 2
              vim.opt_local.shiftwidth = 2
              vim.opt_local.softtabstop = 2
              end,
              })
      -- 1. SET LEADER FIRST
      vim.g.mapleader = " "

      -- 2. General UI & Clipboard
      vim.opt.clipboard = "unnamedplus"
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true
      vim.opt.wrap = false
      vim.opt.scrolloff = 8
      vim.opt.cursorline = true

      -- 3. Theme & Appearance
      require('gruvbox').setup({
		      theme = "dark",
		      })
    vim.cmd([[colorscheme gruvbox]])
    require('smear_cursor').setup({ cursor_color = "#d1d1d1" })
      
      require('lualine').setup {
        options = { theme = 'gruvbox_dark' }
      }

      -- 4. Keybinds
      vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>")
      vim.keymap.set("n", "<leader>w", "<CMD>w<CR>")
      vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")

      -- 5. Plugins Setup
      require("oil").setup()
      
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

      -- 6. Polyglot LSP Setup
      local servers = {
        nixd = { cmd = { "nixd" } },
        clangd = { cmd = { "clangd" } },
        zls = { cmd = { "zls" } },
        rust_analyzer = { cmd = { "rust-analyzer" } },
        gopls = { cmd = { "gopls" } },
        pyright = { cmd = { "pyright-langserver", "--stdio" } },
        ts_ls = { cmd = { "typescript-language-server", "--stdio" } },
        html = { cmd = { "vscode-html-language-server", "--stdio" } },
        cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
        phpactor = { cmd = { "phpactor", "language-server" } },
        kotlin_language_server = { cmd = { "kotlin-language-server" } },
        jdtls = { cmd = { "jdtls" } },
        hls = { cmd = { "haskell-language-server-wrapper", "--lsp" } },
        ocamllsp = { cmd = { "ocamllsp" } }
        ada_ls = { cmd = { "gnatls", "--stdio" } }
      }

      for name, config in pairs(servers) do
        if vim.lsp.config then
          vim.lsp.config(name, config)
          vim.lsp.enable(name)
        end
      end 

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename Symbol" }) 

      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
      })

      -- 7. Autocompletion Setup
      local cmp = require('cmp')
      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        })
      })


      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show line diagnostics" })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

      -- 8. Alpha Dashboard Setup (FIXED)
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.startify')

      -- We set the header and the buttons within the "val" of the sections
      dashboard.section.header.val = {
          [[                               __                ]],
          [[  ___      __    ___   __  __ /\_\    ___ ___    ]],
          [[ /' _ `\  /'__`\ / __`\/\ \/\ \\/\ \  /' __` __`\  ]],
          [[ /\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \ /\ \/\ \/\ \ ]],
          [[ \ \_\ \_\ \____\ \____/\ \___/  \ \_\\ \_\ \_\ \_\]],
          [[  \/_/\/_/\/____/\/___/  \/__/    \/_/ \/_/\/_/\/_/]],
      }

      -- Note the use of a flat list for buttons in the startify theme
      dashboard.section.top_buttons.val = {
          dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
          dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("o", "󰏚  Recent files", ":Telescope oldfiles <CR>"),
          dashboard.button("c", "  Configuration", ":e /etc/nixos/configuration.nix <CR>"),
          dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)

      -- 9. Autopairs Setup
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
		      check_ts = true, -- Enable treesitter integration
		      })

      -- Make autopairs and completion work together
	      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      require('nvim-ts-autotag').setup()

      local scratch_buf = nil
      local scratch_win = nil
      local scratch_path = vim.fn.stdpath("data") .. "/scratchpad.md"

      function ToggleScratchpad()
      if scratch_win and vim.api.nvim_win_is_valid(scratch_win) then
	      vim.api.nvim_command('silent! write') -- Auto-save on close
		      vim.api.nvim_win_close(scratch_win, true)
		      scratch_win = nil
      else
	      -- 1. Create or load the buffer
		      if not scratch_buf or not vim.api.nvim_buf_is_valid(scratch_buf) then
			      scratch_buf = vim.api.nvim_create_buf(false, true)
				      vim.bo[scratch_buf].bufhidden = "hide"
				      vim.bo[scratch_buf].filetype = "markdown"
				      -- Load the file content into the buffer if it exists
				      if vim.fn.filereadable(scratch_path) == 1 then
					      vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, vim.fn.readfile(scratch_path))
						      end
						      end

						      -- 2. Calculate centered dimensions
						      local width = math.floor(vim.o.columns * 0.6)
						      local height = math.floor(vim.o.lines * 0.6)
						      local col = math.floor((vim.o.columns - width) / 2)
						      local row = math.floor((vim.o.lines - height) / 2)

						      -- 3. Open the window
						      scratch_win = vim.api.nvim_open_win(scratch_buf, true, {
								      relative = 'editor',
								      width = width,
								      height = height,
								      col = col,
								      row = row,
								      style = 'minimal',
								      border = 'rounded'
								      })

      -- 4. Auto-save when leaving the buffer or closing nvim
	      vim.api.nvim_create_autocmd({"BufLeave", "VimLeave"}, {
			      buffer = scratch_buf,
			      callback = function()
			      local lines = vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false)
			      vim.fn.writefile(lines, scratch_path)
			      end,
			      })
      end
	      end

	      vim.keymap.set('n', '<leader>sp', ToggleScratchpad, { desc = "Toggle Persistent Scratchpad" })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, { border = "rounded" })

      -- TODO comments
      require("todo-comments").setup({})
      -- Surround
      require("nvim-surround").setup({})
      -- Harpoon
      local harpoon = require("harpoon")
	harpoon:setup()

	vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
	vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

	vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
	vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
	vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
	vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

	vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)
	vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
    -- Indent Blank Line
  require("ibl").setup({
      indent = { char = "│" },
        scope = { enabled = false }, 
        })
'';

    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      kanagawa-nvim
      gruvbox-nvim
      smear-cursor-nvim
      lush-nvim
      nvim-treesitter.withAllGrammars
      lualine-nvim
      nvim-web-devicons
      telescope-nvim
      plenary-nvim
      oil-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      luasnip
      alpha-nvim
      nvim-autopairs
      nvim-ts-autotag
      toggleterm-nvim
      todo-comments-nvim
      nvim-surround
      harpoon2
      indent-blankline-nvim
    ];
  };
}
