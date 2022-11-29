:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set encoding=UTF-8

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

" Show code context
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

" Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'mfussenegger/nvim-dap-python'

call plug#end()

" Custom keymaps
nnoremap <F7> :NvimTreeToggle<cr>
nmap <F8> :TagbarToggle<CR>
" Search git files
nnoremap <c-p> :GFiles<cr>
" Find is case insensitive
nnoremap / /\c
" Go to definition
nmap <silent> gd <Plug>(coc-definition)
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
" Exit insert mode
inoremap jj <ESC>
" Debugging
nnoremap <F5> :lua require'dap'.continue()<cr>
nnoremap <F9> :lua require'dap'.toggle_breakpoint()<cr>
nnoremap <F10> :lua require'dap'.step_over()<cr>
nnoremap <F11> :lua require'dap'.step_into()<cr>
nnoremap <F6> :lua require'dap'.repl.open()<cr>
" Color scheme
" colorscheme carbonfox
colorscheme tokyonight-night

set clipboard=unnamedplus

" Copy to system clipboard
set clipboard=unnamedplus

" Prettier
" Run Prettier on Save
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Nvim tree settings
:lua require("nvim-tree").setup({ reload_on_bufenter = true, update_focused_file = {enable = true, update_root = false, ignore_list = {} } ,actions={ open_file={quit_on_open=true}}})

" Setup context 
:lua require('treesitter-context').setup({enable = true, patterns={default={'class', 'function', 'method'}}})

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

" Debugging
" Python
lua <<EOF
require('dap-python').setup('~/environments/debugpy/bin/python') 
require('dapui').setup()
require ('nvim-dap-virtual-text').setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
EOF
" React
lua <<EOF
local dap = require('dap')
dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = {os.getenv("HOME") .. "/Projects/vscode-chrome-debug/out/src/chromeDebug.js"} -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}
EOF
