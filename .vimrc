set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'vim-scripts/indentpython.vim' "Autoindent
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-fugitive'
Plugin 'yuttie/comfortable-motion.vim'      " Smooth scrolling
Plugin 'thaerkh/vim-indentguides'           " Visual representation of indents
Plugin 'nightsense/carbonized' 		" Colorscheme

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype on
filetype plugin on    " required
filetype plugin indent on    " required

"Folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"PEP8 Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix 

"Stan indentation
au BufNewFile,BufRead *.stan
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set syntax=stan
"
"markdown indentation
au BufNewFile,BufRead *.*md
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=0 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set syntax=markdown

"Flag bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set cursorline
set showmatch
set encoding=utf-8
set scrolloff=20
set clipboard=unnamed

"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"=====================================================
"" Convert formats with Pandoc
""  will set unsupported formats to read only
""  and convert them to markdown.
""  Commented out is an incomplete command to automate 
""    conversion on write. Not sure if I want that 
""    behavior
"=====================================================
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent set ro
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent setlocal nowrap
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -t markdown -o /dev/stdout
"autocmd BufWritePost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -f markdown -t "%" > tmp.jim

"=====================================================
"" Spellcheck Settings 
"=====================================================
"
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt, *.tex silent setlocal spelllang=en_us
"=====================================================
"" Workspace Settings 
"=====================================================
nnoremap <Fc> :ToggleWorkspace<CR>
let g:workspace_autosave_always = 1

"=====================================================
"" Relative Numbering 
"=====================================================
nnoremap <F4> :set relativenumber!<CR>

"=====================================================
"" Search settings
"=====================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

"=====================================================
"" Comfortable Motion Settings
"=====================================================
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_impulse_multiplier = 25  " Feel free to increase/decrease this value.
nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

"=====================================================

"YouCompleteMe customizations
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"Highlighting
let python_highlight_all=1
syntax on

"Colorscheme
if has('gui_running')
	colorscheme darkblue
else
	colorscheme zenburn
endif

"nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] 

"line numbers
set nu
