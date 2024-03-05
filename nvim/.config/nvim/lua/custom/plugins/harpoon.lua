return {
  'theprimeagen/harpoon',
  event = 'VimEnter',
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<leader>a', mark.add_file)
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

    vim.keymap.set('n', '<leader>hj', function()
      ui.nav_file(1)
    end, { desc = 'Move to 1st harpoon' })
    vim.keymap.set('n', '<leader>hk', function()
      ui.nav_file(2)
    end, { desc = 'Move to 2nd harpoon' })
    vim.keymap.set('n', '<leader>hl', function()
      ui.nav_file(3)
    end, { desc = 'Move to 3rd harpoon' })
    vim.keymap.set('n', '<leader>h;', function()
      ui.nav_file(4)
    end, { desc = 'Move to 4th harpoon' })
  end,
}
