"basic  stuff"
	syntax on 
	set nu relativenumber
	set smartindent
	set smarttab
	set nobackup
	set noswapfile
	set nowritebackup
	set hidden
	set wildmenu
	filetype plugin on


au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE


"Plugins"

call plug#begin('~/.local/share/vim/plugins')
  Plug 'sheerun/vim-polyglot'
	Plug 'rwxrob/vim-pandoc-syntax-simple'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'rwxrob/vim-pandoc-syntax-simple'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'tpope/vim-fugitive'
  call plug#end()
"no arrow keys(vi only only!!)

noremap <up> :echoerr "K, hello??"<CR>
noremap <down> :echoerr "k, hello??"<CR>
noremap <right> :echoerr "l, hello??"<CR>
noremap <left> :echoerr "h, hello??"<CR>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

" pandoc

  let g:pandoc#formatting#mode = 'h' " A'
  let g:pandoc#formatting#textwidth = 72
