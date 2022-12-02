set termguicolors
let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha

lua << EOF
require("catppuccin").setup()
EOF

colorscheme catppuccin
highlight Normal guibg=none
highlight NonText guibg=none

