let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set completeopt=menu,menuone,noselect

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
