augroup filetype
  autocmd! BufReadPost,BufNewFile Brewfile set filetype=ruby
  autocmd! BufReadPost,BufNewFile *gitconfig set filetype=gitconfig
  autocmd! BufReadPost,BufNewFile *.cls set filetype=tex
augroup END
