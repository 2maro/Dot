" ==============================================================================
"                               Base Vim Settings
" ==============================================================================
syntax enable
filetype plugin indent on

" Enable full truecolor support for modern terminals (macOS, Windows Terminal, etc.)
set termguicolors

if has('termguicolors')
  set termguicolors
endif

if exists('$TMUX')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set background=dark        " Campbell-style on black
" ==============================================================================
"                         Basic Editor Behaviour
" ==============================================================================
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4
set signcolumn=yes         " keep a fixed gutter for ALE / Git signs

set hidden
set wrap
set linebreak
set wildmenu
set noshowcmd
set nolazyredraw
set nowritebackup
set nobackup
set noswapfile
set history=100
set undofile
set undodir=~/.vim/undodir
set mouse=
set showmode
set shortmess=aoOtTI
set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)
let mapleader=' '
" ==============================================================================
"                      Filetype Detection and Autocmd Helpers
" ==============================================================================
autocmd BufNewFile,BufRead *.vimrc,.vimrc,init.vim             set ft=vim
autocmd BufNewFile,BufRead .bashrc,.bash_profile,*.profile     set ft=sh
autocmd BufNewFile,BufRead *.go                                set ft=go
autocmd BufNewFile,BufRead *.crontab                           set ft=crontab
autocmd BufNewFile,BufRead */ssh/config                        set ft=sshconfig
autocmd BufNewFile,BufRead *.gitconfig                         set ft=gitconfig
autocmd BufNewFile,BufRead .dockerignore                       set ft=gitignore
autocmd BufNewFile,BufRead */tasks/*.yaml,*/handlers/*.yaml    set ft=yaml.ansible
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif

" ==============================================================================
"                       Campbell-Inspired Highlight Overrides
" ==============================================================================
function! s:Campbell() abort
  hi clear
  if exists('syntax_on') | syntax reset | endif
 set background=dark
 " Base Text & UI
  hi Normal        guifg=#ebdbb2 guibg=#000000 ctermfg=223 ctermbg=16
  hi NormalNC      guifg=#ebdbb2 guibg=#000000 ctermfg=223 ctermbg=16
  hi LineNr        guifg=#665c54 guibg=#000000 ctermfg=242 ctermbg=16
  hi SignColumn    guifg=#665c54 guibg=#000000 ctermfg=242 ctermbg=16
  hi FoldColumn    guifg=#665c54 guibg=#000000 ctermfg=242 ctermbg=16
  hi VertSplit     guifg=#3c3836 guibg=#000000 ctermfg=237 ctermbg=16
  hi ColorColumn   guibg=#000000                   ctermbg=16
  hi CursorLine    guibg=#000000                   ctermbg=16
  hi CursorLineNr  guifg=#fabd2f guibg=#000000 ctermfg=214 ctermbg=16
  hi StatusLine    guifg=#ebdbb2 guibg=#3c3836 ctermfg=223 ctermbg=237
  hi StatusLineNC  guifg=#928374 guibg=#000000 ctermfg=245 ctermbg=16
  hi CursorColumn  guibg=#000000                   ctermbg=16
  hi WinSeparator  guifg=#3c3836 guibg=#000000 ctermfg=237 ctermbg=16

  " Syntax Highlighting
  hi Comment       guifg=#928374 gui=italic ctermfg=245 cterm=italic
  hi Constant      guifg=#D68C8C ctermfg=211
  hi String        guifg=#fabd2f ctermfg=214
  hi Statement     guifg=#D68C8C gui=bold ctermfg=211 cterm=bold
  hi Function      guifg=#b8bb26 gui=bold ctermfg=142 cterm=bold
  hi Identifier    guifg=#ebdbb2 ctermfg=223
  hi Type          guifg=#83a598 ctermfg=109
  hi PreProc       guifg=#83a598 ctermfg=109
  hi Label         guifg=#fe8019 ctermfg=208
  hi Directory     guifg=#b8bb26 ctermfg=142
  hi SpecialKey    guifg=#d79921 ctermfg=172
  hi NonText       guifg=#504945 ctermfg=239
  hi Error         guibg=#000000 guifg=#000000 ctermbg=16 ctermfg=16
  hi SpellBad      guibg=#000000 guifg=#000000 ctermbg=16 ctermfg=16
  hi Visual        guibg=#504945 guifg=NONE ctermbg=239 ctermfg=NONE 
  " Diff/Git
  hi DiffAdd       guifg=#b8bb26 guibg=NONE ctermfg=142 ctermbg=NONE
  hi DiffDelete    guifg=#fb4934 guibg=NONE ctermfg=167 ctermbg=NONE
  hi DiffChange    guifg=#83a598 guibg=NONE ctermfg=109 ctermbg=NONE

  " Linting (ALE)
  hi! link ALEInfoSign Comment
  hi! link ALEHintSign Comment
  hi ALEErrorSign   guifg=#ff5555 guibg=#000000 ctermfg=203 ctermbg=16
  hi ALEWarningSign guifg=#ffaa00 guibg=#000000 ctermfg=214 ctermbg=16
  hi ALEInfoSign    guifg=#83a598 guibg=#000000 ctermfg=109 ctermbg=16
  hi ALEHintSign    guifg=#b8bb26 guibg=#000000 ctermfg=142 ctermbg=16
endfunction

call s:Campbell()
autocmd ColorScheme * call s:Campbell()

" ==============================================================================
"                               Plugins (vim-plug)
" ==============================================================================
call plug#begin('~/.vim/plugged')
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'sheerun/vim-polyglot'
  Plug 'fatih/vim-go',          { 'do': ':GoUpdateBinaries' }
  Plug 'hashivim/vim-terraform'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'

call plug#end()

" ==============================================================================
"                                ALE Config
" ==============================================================================
let g:ale_sign_error   = '☠'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info    = '🧠'
let g:ale_sign_hint    = '🤔'

let g:ale_linters = {
  \ 'go':        ['golangci-lint', 'gofmt', 'gobuild'],
  \ 'terraform': ['tflint'],
  \ 'sh':        ['shellcheck'],
  \ 'bash':      ['shellcheck'],
  \ 'yaml':      ['ansible_lint', 'yamllint'],
  \ 'dockerfile':['hadolint'],
\}

let g:ale_fixers = {
  \ 'go':        ['gofmt', 'goimports'],
  \ 'terraform': ['terraform'],
  \ 'sh':        ['shfmt'],
  \ 'bash':      ['shfmt'],
  \ 'yaml':      ['prettier'],
\}

let g:ale_set_quickfix          = 1
let g:ale_set_signs             = 1
let g:ale_linter_aliases        = {'bash': 'sh'}
let g:ale_fix_on_save           = 1
let g:ale_virtualtext_cursor    = 'current'
let g:ale_completion_enabled    = 0
let g:ale_lint_on_text_changed  = 'never'
let g:ale_lint_on_insert_leave  = 1
let g:ale_lint_on_enter         = 1
let g:ale_yaml_yamllint_options = '--disable-rule=line-length'
let g:ale_yaml_ansible_lint_options = '--skip-list var-naming[no-role-prefix]'

" ==============================================================================
"                                Go Extras
" ==============================================================================
let g:go_fmt_command              = 'goimports'
let g:go_fmt_autosave             = 1
let g:go_gopls_enabled            = 1
let g:go_def_mapping_enabled      = 0
let g:go_auto_type_info           = 1
let g:go_highlight_types          = 1
let g:go_highlight_fields         = 1
let g:go_highlight_functions      = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators      = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_format_strings = 1
let g:go_auto_sameids             = 0
let g:go_version_warning          = 0
" ==============================================================================
"                                Key Mappings
" ==============================================================================
nnoremap <C-L> :nohlsearch<CR><C-L>
autocmd FileType go nnoremap <leader>n if err != nil { return err }<CR><Esc>

" ==============================================================================
"                              Tmux Window Rename
" ==============================================================================
if exists('$TMUX')
  autocmd BufEnter * call system('tmux rename-window ' .
        \ expand('%:p:h:t') . '/' . expand('%:t'))
endif
