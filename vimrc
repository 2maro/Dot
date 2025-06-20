" Enable syntax highlighting and file type detection
syntax on
filetype plugin indent on

" Indentation settings
set smartindent
set smarttab
set expandtab         " Use spaces instead of tabs
set shiftwidth=4      " Number of spaces for each indentation level
set tabstop=4         " Number of spaces that a <Tab> in the file counts for
set signcolumn=yes

" Disable backup files
set nobackup
set noswapfile
set nowritebackup
set hidden            " Allow buffer switching without saving

" Interface enhancements
set wildmenu
set showmode
set noshowcmd
set wrap
set linebreak
set number            " Show line numbers

" Performance and encoding
set encoding=utf-8
set fileencodings=utf-8
set updatetime=300    " Faster completion
set t_vb=             " Disable visual bell
set background=dark

" Search settings
set hlsearch          " Highlight search results
set incsearch         " Incremental search
set ignorecase        " Case-insensitive search
set smartcase         " Case-sensitive if uppercase letters are used

" History and undo
set history=100
set undofile          " Enable persistent undo
set undodir=~/.vim/undodir

" Status line
set omnifunc=syntaxcomplete#Complete
set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

set nolazyredraw

" Short messages
set shortmess=aoOtTI

" Map leader key
let mapleader=" "

" Remove command line messages
set noshowmode

" Disable sound on errors
set noerrorbells
set visualbell

set mouse=
set noruler
set nonumber

" ==============================================================================
"                                Key Mappings
" ==============================================================================

" Clear search highlighting with Ctrl+L
nnoremap <C-L> :nohlsearch<CR><C-L>

" Quickly sallow ctermbg=NONE
autocmd FileType markdown,pandoc hi Operator ctermfg=yellow ctermbg=NONE
autocmd FileType yaml hi yamlBlockMappingKey ctermfg=81

" ==============================================================================
"                           Color Scheme and Highlighting
" ==============================================================================

" Custom highlight groups
hi LineNr ctermfg=darkgray ctermbg=NONE
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
hi SignColumn ctermbg=NONE

" FileType-specific highlighting
autocmd FileType * hi Special ctermfg=cyan
autocmd FileType * hi SpecialKey ctermfg=black ctermbg=NONE
autocmd FileType * hi ModeMsg ctermfg=black cterm=NONE ctermbg=NONE
autocmd FileType * hi MoreMsg ctermfg=black ctermbg=NONE
autocmd FileType * hi NonText ctermfg=black ctermbg=NONE
autocmd FileType * hi vimGlobal ctermfg=black ctermbg=NONE
autocmd FileType * hi goComment ctermfg=black ctermbg=NONE
autocmd FileType * hi ErrorMsg ctermbg=234 ctermfg=darkred cterm=NONE
autocmd FileType * hi Error ctermbg=234 ctermfg=darkred cterm=NONE
autocmd FileType * hi SpellBad ctermbg=234 ctermfg=darkred
autocmd FileType * hi SpellRare ctermbg=234 ctermfg=darkred
autocmd FileType * hi Search ctermbg=236 ctermfg=darkred
autocmd FileType * hi vimTodo ctermbg=236 ctermfg=darkred
autocmd FileType * hi Todo ctermbg=236 ctermfg=darkred
autocmd FileType * hi IncSearch ctermbg=236 cterm=NONE ctermfg=darkred
autocmd FileType * hi MatchParen ctermbg=236 ctermfg=darkred
autocmd FileType markdown,pandoc hi Title ctermfg=yellow ctermbg=NONE
autocmd FileType markdown,pandoc hi Operator 


" ==============================================================================
"                                 Plugins Setup
" ==============================================================================

" Plugin manager initialization
call plug#begin('~/.vim/plugged')

" Plugin list
Plug 'sheerun/vim-polyglot'                        " Language pack
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go development
Plug 'hashivim/vim-terraform'                      " Terraform support
Plug 'machakann/vim-sandwich'                      " Text object manipulation
Plug 'tpope/vim-fugitive'                          " Git integration
Plug 'dense-analysis/ale'                          " Asynchronous linting

call plug#end()

" =============================================================================
"                              Plugin Configurations
" =============================================================================

" --- ALE Configuration ---
let g:ale_sign_error = '☠'
let g:ale_sign_warning = '⚠️'

let g:ale_linters = {
      \ 'go': ['golangci-lint', 'gofmt', 'gobuild'],
      \ 'terraform': ['tflint'],
      \ 'sh': ['shellcheck'],
      \ 'bash': ['shellcheck'],
      \ 'yaml': ['ansible_lint','yamllint'],
      \ 'dockerfile': ['hadolint'],
\ }

let g:ale_set_quickfix = 1
let g:ale_set_signs = 1
let g:ale_linter_aliases = {'bash': 'sh'}

let g:ale_fixers = {
      \ 'go': ['gofmt', 'goimports'],
      \ 'terraform': ['terraform'],
      \ 'sh': ['shfmt'],
      \ 'bash': ['shfmt'],
      \ 'yaml': ['prettier'],
\ }

let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 'current'
let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_yaml_yamllint_options = '--disable-rule=line-length'
let g:ale_yaml_ansible_lint_options = '--skip-list var-naming[no-role-prefix]'

" --- vim-go Configuration ---
let g:go_fmt_command = 'goimports'
let g:go_fmt_autosave = 1
let g:go_gopls_enabled = 1
let g:go_def_mapping_enabled = 0
let g:go_auto_type_info = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1
let g:go_auto_sameids = 0
let g:ale_yaml_ansible_lint_options = '--skip-list var-naming[no-role-prefix]'
let g:go_version_warning = 0
" --- vim-terraform Configuration ---
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
let g:terraform_highlight_errors = 1


" Start editing at the last known position
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   execute "normal! g'\"" |
      \ endif

" Set indentation and settings for specific file types
autocmd FileType yaml,json,terraform setlocal shiftwidth=2 tabstop=2 expandtab
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4

" Enable spell checking for certain file types
autocmd BufRead,BufNewFile *.md,*.txt,*.go setlocal spell

" Disable ALE warning/error text highlight (but keep signs & messages)
highlight ALEWarning cterm=NONE ctermfg=NONE ctermbg=NONE
highlight ALEError cterm=NONE ctermfg=NONE ctermbg=NONE
highlight ALEInfo cterm=NONE ctermfg=NONE ctermbg=NONE

" Recognize additional file types
autocmd BufRead,BufNewFile *.profile set filetype=sh
autocmd BufRead,BufNewFile *.crontab set filetype=crontab
autocmd BufRead,BufNewFile */ssh/config set filetype=sshconfig
autocmd BufRead,BufNewFile *.gitconfig set filetype=gitconfig
autocmd BufRead,BufNewFile .dockerignore set filetype=gitignore
autocmd BufRead,BufNewFile */tasks/*.yaml,*/handlers/*.yaml set filetype=yaml.ansible
" Highlight Pmenu for autocompletion menu
autocmd FileType * highlight Pmenu ctermbg=234 ctermfg=white

" =============================================================================
"                              Additional Mappings
" =============================================================================

" Go-specific mappings
autocmd FileType go nnoremap <leader>n if err != nil { return err }<CR><Esc>
