return {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          -- first key is the mode
          n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
            ["<Leader>bD"] = {
              function()
                require("astroui.status").heirline.buffer_picker(function(bufnr)
                  require("astrocore.buffer").close(bufnr)
                end)
              end,
              desc = "Pick to close",
            },
            -- tables with the `name` key will be registered with which-key if it's installed
            -- this is useful for naming menus
            ["<Leader>b"] = { name = "Buffers" },
            -- "s1n7ax/nvim-window-picker"
            ["<leader>Wp"] = { 
                function() require('window-picker').pick_window() end,
                desc = "Pick window",
            },
            -- "smoka7/multicursors.nvim"
            ["<leader>m"] = { "<cmd>MCStart<cr>", desc = "Create a selection for selected text or word under the cursor" },
            ["<leader>tr"] = { "<cmd>ExecutorRun<CR>", noremap = true, silent = true },
            ["<leader>tV"] = { "<cmd>ExecutorToggleDetail<CR>", noremap = true, silent = true },
            ["<leader>tR"] = { "<cmd>ExecutorReset<CR>", noremap = true, silent = true },
            -- quick save
            -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          },
          t = {
            -- setting a mapping to false will disable it
            -- ["<esc>"] = false,
          },
        },
      },
    },
    {
      "AstroNvim/astrolsp",
      ---@type AstroLSPOpts
      opts = {
        mappings = {
          n = {
            -- this mapping will only be set in buffers with an LSP attached
            K = {
              function()
                vim.lsp.buf.hover()
              end,
              desc = "Hover symbol details",
            },
            -- condition for only server with declaration capabilities
            gD = {
              function()
                vim.lsp.buf.declaration()
              end,
              desc = "Declaration of current symbol",
              cond = "textDocument/declaration",
            },
          },
        },
      },
    },
  }
