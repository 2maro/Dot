"basic  stuff
"
	syntax on 
	filetype plugin on
	set nu 
	set smartindent
	set smarttab
	set nobackup
	set noswapfile
	set nowritebackup
	set hidden
	set wildmenu
	set textwidth=72
	set ttyfast
	set encoding=utf-8
	set fileencodings=utf-8
	set updatetime=100
	set background=dark
"Plugins"

call plug#begin('~/.vim/plugins')
  Plug 'sheerun/vim-polyglot'
	Plug 'NLKNguyen/papercolor-theme'
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'rwxrob/vim-pandoc-syntax-simple'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'tpope/vim-fugitive'
call plug#end()


noremap <up> :echo "K, hello??"<CR>
noremap <down> :echo "k, hello??"<CR>
noremap <right> :echo "l, hello??"<CR>
noremap <left> :echo "h, hello??"<CR>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

let mapleader=" "
set spc=
set spell
set icon
set shortmess=aoOtTI

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

	"au bufnewfile,bufRead *.go set spell"
	"au bufnewfile,bufRead *.bash* set ft=bash

	au BufRead,BufNewFile *bash* let g:is_bash=1
	au bufnewfile,bufRead *.profile set filetype=sh
	au bufnewfile,bufRead *.crontab set filetype=crontab
	au bufnewfile,bufRead *ssh/config set filetype=sshconfig
	au bufnewfile,bufRead commands.yaml set spell

	au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
	au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE

	au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
	au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
	au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
	"au FileType * hi goComment ctermfg=black ctermbg=NONE
	au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
	au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE

	au FileType go nmap <leader>t :GoTest!<CR>
	au FileType go nmap <leader>v :GoVet!<CR>
	au FileType go nmap <leader>b :GoBuild!<CR>
	au FileType go nmap <leader>c :GoCoverageToggle<CR>
	au FileType go nmap <leader>i :GoInfo<CR>
	au FileType go nmap <leader>l :GoMetaLinter!<CR>
	au FileType go nmap <leader>r :GoRun!<CR>
	
