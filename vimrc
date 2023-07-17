"basic stuff"
  syntax on
  filetype plugin on
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
  set hlsearch
  set incsearch
  set linebreak
  set wrapscan
  set history=100
  set omnifunc=syntaxcomplete#Complete
  set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)
  set t_vb=
  set icon
  set shortmess=aoOtTI
  set spc=
  set showmode


nnoremap <C-L> :nohl<CR><C-L>
hi SpecialKey ctermfg=black ctermbg=NONE
hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
hi MoreMsg ctermfg=black ctermbg=NONE
hi NonText ctermfg=black ctermbg=NONE
hi vimGlobal ctermfg=black ctermbg=NONE
hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
hi Error ctermbg=234 ctermfg=darkred cterm=NONE
hi SpellBad ctermbg=234 ctermfg=darkgreen cterm=NONE
hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
hi Search ctermbg=236 ctermfg=darkred
hi vimTodo ctermbg=236 ctermfg=darkred
hi Todo ctermbg=236 ctermfg=darkred
hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
hi MatchParen ctermbg=236 ctermfg=darkred

"color overrides"
au FileType * hi Special ctermfg=cyan
au FileType * hi SpecialKey ctermfg=black ctermbg=NONE
au FileType * hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
au FileType * hi MoreMsg ctermfg=black ctermbg=NONE
au FileType * hi NonText ctermfg=black ctermbg=NONE
au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
au FileType * hi goComment ctermfg=black ctermbg=NONE
au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
au FileType * hi Search ctermbg=236 ctermfg=darkred
au FileType * hi vimTodo ctermbg=236 ctermfg=darkred
au FileType * hi Todo ctermbg=236 ctermfg=darkred
au FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
au FileType * hi MatchParen ctermbg=236 ctermfg=darkred
au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE
au FileType yaml hi yamlBlockMappingKey ctermfg=NONE

"Plugins"
  call plug#begin('~/.vim/plugins')
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'hashivim/vim-terraform'
  Plug 'tpope/vim-surround'
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
" terraform

  let g:terraform_fmt_on_save = 1
  autocmd FileType * :highlight Pmenu ctermbg=234 
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  au BufRead,BufNewFile *bash* let g:is_bash=1
  au bufnewfile,bufRead *.profile set filetype=sh
  au bufnewfile,bufRead *.crontab set filetype=crontab
  au bufnewfile,bufRead *ssh/config set filetype=sshconfig
  ""au bufnewfile,bufRead commands.yaml set spell
  au bufnewfile,bufRead *.go set spell spellcapcheck=0
  au bufnewfile,bufRead *gitconfig set filetype=gitconfig
  au bufnewfile,bufRead *ssh/config set filetype=sshconfig
  au bufnewfile,bufRead .dockerignore set filetype=gitignore

  au FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
  au FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE

  au FileType yaml set sw=4
  "au FileType * hi SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
  "au FileType * hi SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
  au FileType * hi vimGlobal ctermfg=black ctermbg=NONE
  "au FileType * hi goComment ctermfg=black ctermbg=NONE
  au FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
  au FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
  au FileType go nmap <leader>n if err != nil {return err}<CR><ESC>
