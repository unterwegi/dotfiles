-- Auto save when switching/hiding buffers
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    -- skip buffers that can't be modified (read-only)
    -- also skip buffers that don't have a name yet (% == "")
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
    end
  end,
})
