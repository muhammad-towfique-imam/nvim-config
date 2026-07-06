require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "new tab" })
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "close tab" })
map("n", "<leader>tt", function()
  vim.cmd "tabnew | terminal"
  vim.cmd "startinsert"
end, { desc = "terminal in new tab" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
