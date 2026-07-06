require "nvchad.autocmds"

-- Make terminal buffers listed so they appear in the bufferline & Telescope buffers.
-- NvChad's term module sets buflisted=false in M.display() before termopen fires,
-- so this TermOpen callback runs afterwards and overrides it back to listed.
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "List terminal buffers (show in bufferline / Telescope buffers)",
  callback = function(args)
    vim.bo[args.buf].buflisted = true
  end,
})
