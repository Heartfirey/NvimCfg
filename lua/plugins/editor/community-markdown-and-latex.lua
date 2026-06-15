return {
  -- Preview markdown on your modern browser with synchronised scrolling and flexible configuration
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  -- Run install.sh synchronously so lazy waits on the prebuilt-binary download
  -- and surfaces a real error on failure, instead of the async fire-and-forget
  -- `mkdp#util#install()` that silently "succeeds" with no binary downloaded.
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && ./install.sh",
  },
  -- in-buffer markdown rendering (also prettifies CodeCompanion chat output)
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
}
