-- venv-selector is already provided by `astrocommunity.pack.python`.
-- This spec only layers on the conda search paths + keymaps so the two
-- definitions merge instead of fighting (previously a full `config` override
-- here silently shadowed the pack's setup).
return {
  "linux-cultist/venv-selector.nvim",
  opts = {
    settings = {
      search = {
        anaconda_envs = {
          command = "fd bin/python$ /Users/heartfirey/Workspace/CondaEnv --full-path --color never -E /proc",
        },
        anaconda_base = {
          command = "fd base/bin/python$ /opt/homebrew/Caskroom/miniconda/base --full-path --color never -E /proc",
        },
      },
    },
  },
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select cached VirtualEnv" },
  },
}
