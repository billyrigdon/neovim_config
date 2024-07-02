call plug#begin('~/.config/nvim/plugged')

" Existing plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'preservim/nerdtree'
Plug 'dart-lang/dart-vim-plugin'
Plug 'github/copilot.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Additional plugins for Flutter development and other enhancements
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jiangmiao/auto-pairs'
Plug 'thosakwe/vim-flutter'
Plug 'Yggdroot/indentLine'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'dense-analysis/ale'

call plug#end()

" General settings
set tabstop=2
set shiftwidth=2
set expandtab
set number

" Colorscheme
try
  colorscheme catppuccin
catch
  colorscheme default
endtry

" NERDTree settings
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-s> :wincmd p<CR>
autocmd VimEnter * NERDTree | wincmd p

" Enable Rainbow Parentheses
au VimEnter * RainbowParenthesesActivate

" Flutter settings
let g:dart_format_on_save = v:true

" CoC settings
let g:coc_global_extensions = ['coc-flutter', 'coc-json', 'coc-tsserver']

" Use tab to confirm completion and arrow keys to navigate the completion menu
inoremap <silent><expr> <Tab> pumvisible() ? coc#_select_confirm() : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-S-Down> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <silent><expr> <C-S-Up> pumvisible() ? "\<C-p>" : "\<Up>"



" GitHub Copilot settings
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")

" ALE settings for linting and formatting
let g:ale_linters = {
\   'dart': ['dartanalyzer'],
\}
let g:ale_fixers = {
\   'dart': ['dartfmt'],
\}
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 1

" Enable ALE fixers on save
autocmd BufWritePre *.dart ALEFix

" LSP settings
lua << EOF
local nvim_lsp = require'lspconfig'

nvim_lsp.tsserver.setup{
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end
}
EOF

" FZF settings for searching in files
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.Trash/*"'
nnoremap <C-S-F> :Rg<CR>
" Go to definition
nmap <silent> <C-S-D> <Plug>(coc-definition)

" Show documentation
nnoremap <silent> <C-K> :call CocActionAsync('doHover')<CR>

" Type hints and available methods/properties
autocmd CursorHold * silent call CocActionAsync('highlight')

" Show all diagnostics
nnoremap <silent> <C-d> :CocList diagnostics<CR>

" Go to previous diagnostic
nnoremap <silent> <C-[> :call CocAction('diagnosticPrevious')<CR>

" Go to next diagnostic
nnoremap <silent> <C-]> :call CocAction('diagnosticNext')<CR>

" Show all commands
nnoremap <silent> <C-x> :CocList commands<CR>

" List all symbols
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
