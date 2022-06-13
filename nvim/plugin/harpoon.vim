nnoremap <silent> <TAB>     :lua require("harpoon.ui").nav_next()<CR>
nnoremap <silent> <S-TAB>     :lua require("harpoon.ui").nav_prev()<CR>
nnoremap <silent> <leader>a :lua require("harpoon.mark").toggle_file()<CR>
nnoremap <silent> <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>
