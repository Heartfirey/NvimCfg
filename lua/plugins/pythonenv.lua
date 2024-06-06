return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python', 'nvim-lua/plenary.nvim', "mfussenegger/nvim-dap", },
  branch = "regexp",
  config = function()
    require('venv-selector').setup {
      settings = {
        search = {
          anaconda_envs = {
            command = "fd bin/python$ /Users/heartfirey/Workspace/CondaEnv --full-path --color never -E /proc" -- change path here to your anaconda envs
          },
          anaconda_base = {
            command = "fd base/bin/python$ /opt/homebrew/Caskroom/miniconda/base --full-path --color never -E /proc", -- change path here to your anaconda base
          },
        },
      },
      anaconda_base_path = "",
    }
  end,
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>vs', '<cmd>VenvSelect<cr>' },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
  },
}
