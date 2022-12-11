if exists('g:vscode')
	" VSCode extension
else
	" Ordinary Neovim
    set cursorline
    set cursorcolumn

    lua vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
endif

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin()
    Plug 'tanvirtin/monokai.nvim'

    " Movement
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'frazrepo/vim-rainbow'
    Plug 'ggandor/leap.nvim'
    Plug 'ggandor/flit.nvim'
    Plug 'ggandor/leap-spooky.nvim'
    Plug 'tpope/vim-commentary'

    " For telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    Plug 'sheerun/vim-polyglot'

    " Treesitter plugins 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'

    " lsp-based code completions
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Needed for noice
    Plug 'MunifTanjim/nui.nvim'
    Plug 'rcarriga/nvim-notify'
    Plug 'ryanoasis/vim-devicons'
    Plug 'folke/noice.nvim'

    " C++ language server
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'vim-syntastic/syntastic'

    Plug 'honza/vim-snippets'
    Plug 'scrooloose/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'mhinz/vim-startify'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'ekalinin/Dockerfile.vim'

call plug#end()

" configuration for fzf
lua require('telescope').load_extension('fzf')
lua require('noice').setup()

set incsearch

set number
set nowrap
set colorcolumn=90

lua require('leap').add_default_mappings()
lua require('flit').setup()
lua require('leap-spooky').setup()


" Lsp configureation
lua require'lspconfig'.pyright.setup{}

" Mappings for mac clipboard copy paste
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from system: clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

colorscheme monokai
let g:rainbow_active = 1

" vhdl macros
" delete blank lines global command: 'g/^\s*$/d'
" clear comments replace: 's/--./ '
"
" Copy an entity
noremap <leader>vc ?entity .* isv/entity;$"ay:noh
noremap <leader><space> :noh<CR>

" convert a port map to an instance
let @r='^"cyef:C=> c,'

" clear comments: 's/--.*/^M'
" clear blank lines: g/^\s*$/d
" convert from port/generic to map: ^ea mapf(v%:s/--.*/?mapf(v%:g/^\s*$/dv%k$oj0^0:norm! ^"cyef:C=> "cpa,xjx 
"
