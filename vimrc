"basic  stuff"
"
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
	set textwidth=72
	set ttyfast

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

" golang" 

  let g:go_fmt_fail_silently = 0
	let g:go_fmt_command = 'goimports'
  let g:go_fmt_autosave = 1
	let g:go_gopls_enabled = 1
	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_operators = 1
	let g:go_highlight_extra_types = 1
	let g:go_highlight_variable_declarations = 1
	let g:go_highlight_variable_assignments = 1
	let g:go_highlight_build_constraints = 1
	let g:go_highlight_diagnostic_errors = 1
	let g:go_highlight_diagnostic_warnings = 1
  let g:go_auto_sameids = 0

	set updatetime=100

	au FileType go nmap <leader>t :GoTest!<CR>
	au FileType go nmap <leader>v :GoVet!<CR>
	au FileType go nmap <leader>b :GoBuild!<CR>
	au FileType go nmap <leader>c :GoCoverageToggle<CR>
	au FileType go nmap <leader>i :GoInfo<CR>
	au FileType go nmap <leader>l :GoMetaLinter!<CR>

  
