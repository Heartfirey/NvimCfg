-- CodeCompanion: AI chat / inline / agent assistant.
--
-- Integration note for this setup:
--   The company ships *wrapped* Claude Code / Codex CLIs (auth handled by the
--   client itself), and raw model APIs are NOT available. So we drive them
--   through CodeCompanion's CLI interaction (`:CodeCompanionCLI`), which just
--   wraps the agent CLI in a terminal -- no API key/ACP token needed here.
--
--   >>> TODO: replace the `cmd` placeholders below with the real in-house
--   >>> command names once known (e.g. "company-claude", "company-codex").
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionCLI",
    "CodeCompanionCmd",
    "CodeCompanionActions",
  },
  init = function()
    -- expand `cc` to `CodeCompanion` on the command line
    vim.cmd [[cab cc CodeCompanion]]
  end,
  opts = {
    interactions = {
      -- Agent mode (recommended for this setup): terminal-wrapped CLI agents.
      cli = {
        agent = "claude_code", -- default agent for :CodeCompanionCLI
        agents = {
          claude_code = {
            cmd = "claude", -- TODO: in-house wrapped Claude Code command
            args = {},
            description = "Claude Code (in-house)",
            provider = "terminal",
          },
          codex = {
            cmd = "codex", -- TODO: in-house wrapped Codex command
            args = {},
            description = "Codex (in-house)",
            provider = "terminal",
          },
        },
      },
    },
  },
  specs = {
    -- which-key group label + a couple of buffer/visual helpers
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>a"] = { desc = " AI (CodeCompanion)" },
          },
          v = {
            ["<Leader>a"] = { desc = " AI (CodeCompanion)" },
          },
        },
      },
    },
  },
  keys = {
    { "<Leader>aC", "<cmd>CodeCompanionCLI<cr>", mode = { "n", "v" }, desc = "CLI agent (Claude/Codex)" },
    { "<Leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle chat" },
    { "<Leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action palette" },
    { "<Leader>ai", ":CodeCompanion ", mode = { "n", "v" }, desc = "Inline prompt" },
    { "<Leader>ax", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to chat" },
  },
}
