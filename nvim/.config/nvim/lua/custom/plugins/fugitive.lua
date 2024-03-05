return {
  'tpope/vim-fugitive',
  event = 'VimEnter',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status' })
  end,
}
