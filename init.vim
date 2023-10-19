:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set encoding=UTF-8
" Coc Related
:set updatetime=300
:set signcolumn=yes

call plug#begin()
" Search within files 
Plug 'dyng/ctrlsf.vim'
" Fuzzy file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Commenting out lines, gcc
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc

" Bottom status bar
Plug 'https://github.com/vim-airline/vim-airline' 

" CSS color preview
Plug 'https://github.com/ap/vim-css-color' 

" Auto completion
Plug 'https://github.com/neoclide/coc.nvim'  

" Tagbar for code navidation
Plug 'https://github.com/preservim/tagbar' 

" File tree
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Code formatting
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }

" Git status
Plug 'airblade/vim-gitgutter'

" Color Themes
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'ayu-theme/ayu-vim'

" Show code context
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

"Copilot
Plug 'github/copilot.vim'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'

" ARM syntax
Plug 'ARM9/arm-syntax-vim'

Plug 'udalov/kotlin-vim'

call plug#end()

set runtimepath+=/opt/homebrew/share/lua/5.1/typer
command! TypeThis :lua require'typer'.type()

au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
" Custom keymaps
nnoremap <F7> :NvimTreeToggle<cr>
nmap <F8> :TagbarToggle<CR>
" Search git files
nnoremap <c-p> :Files<cr>
" Find is case insensitive
nnoremap / /\c
" Go to definition
nmap <silent> gd <Plug>(coc-definition)
" Go to references
nmap <silent> gr <Plug>(coc-references)
" insert console.log
inoremap <c-l> <c-c>oconsole.log()<left>
" Make function braces
inoremap <c-)> ){<cr>}<c-c><s-o><tab>
" Accept auto complete with TAB
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
" Split window
nnoremap <c-s> :vsp<cr>
" Get variable/function info
nnoremap <silent> K :call CocActionAsync("doHover")<CR>
" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Dont yank on line delete
" nnoremap p "0p
" Exit insert mode
inoremap jj <ESC>
" :OR command to organize imports
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
" Debugging
nnoremap <F5> :lua require'dap'.continue()<cr>
nnoremap <F9> :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <F10> :lua require'dap'.step_over()<cr>
nnoremap <F11> :lua require'dap'.step_into()<cr>
nnoremap <F6> :lua require'dap'.repl.open()<cr>
" Color scheme
" colorscheme carbonfox
colorscheme tokyonight-night
" colorscheme catppuccin
set termguicolors     " enable true colors support
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

" Copy to system clipboard
set clipboard=unnamedplus

" Prettier
" Run Prettier on Save
" let g:prettier#autoformat = 1
" let g:prettier#partial_format=1
" let g:prettier#autoformat_require_pragma = 0
" let g:prettier#exec_cmd_async = 1
" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
" command! -nargs=0 Prettier :CocCommand prettier.formatFile

" " Nvim tree settings
:lua require("nvim-tree").setup({ reload_on_bufenter = true, update_focused_file = {enable = true, update_root = false, ignore_list = {} } ,actions={ open_file={quit_on_open=true}}})

" " Setup context 
:lua require('treesitter-context').setup({enable = true, })

" lua << EOF
" require'nvim-treesitter.configs'.setup {
"   ensure_installed = "maintained",
"   highlight = {
"     enable = true,
"   },
" }
" EOF

" Return last line in file when opened
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" CtrlSF search in files
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_auto_close = {
    \ "normal" : 1,
    \ "compact": 1
    \}
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

" Tagbar
" Make tagbar work with react
let g:tagbar_type_typescriptreact = {
\ 'ctagstype': 'typescript',
\ 'kinds': [
  \ 'c:class',
  \ 'n:namespace',
  \ 'f:function',
  \ 'G:generator',
  \ 'v:variable',
  \ 'm:method',
  \ 'p:property',
  \ 'i:interface',
  \ 'g:enum',
  \ 't:type',
  \ 'a:alias',
\ ],
\'sro': '.',
  \ 'kind2scope' : {
  \ 'c' : 'class',
  \ 'n' : 'namespace',
  \ 'i' : 'interface',
  \ 'f' : 'function',
  \ 'G' : 'generator',
  \ 'm' : 'method',
  \ 'p' : 'property',
  \},
\ }
" Settings
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

highlight Normal guibg=#090B17
