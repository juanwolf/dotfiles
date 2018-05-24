call plug#begin('~/.vim/plugged')
" Vim look
Plug 'yggdroot/indentline' " Displays line for indentation
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'
Plug 'altercation/vim-colors-solarized' " Cause I can't choose between previous one or this one

" Git plugin
Plug 'tpope/vim-fugitive' " Git command in vim
Plug 'airblade/vim-gitgutter' " Display changes in file

" Navigation
Plug 'scrooloose/nerdtree' " Project files navigation
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Add colors in nerdtree
Plug 'kien/ctrlp.vim' " Ctrl+p -> search file
Plug 'mileszs/ack.vim' " Grep wrapper. Please look at http://beyondgrep.com/install/ for ack installation.
Plug 'majutsushi/tagbar' " TagBar to work with ctags

" CTags generator
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" Code syntax
Plug 'scrooloose/syntastic', { 'do': 'sudo npm install -g jsonlint jshint js-yaml tslint'}
Plug 'godlygeek/tabular'

" Code completion
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --tern-completer; sudo npm install -g typescript' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif


" Devops tools
Plug 'fatih/vim-hclfmt' " Hashicorp file syntax
Plug 'stephpy/vim-yaml' " Better yaml syntax
Plug 'chase/vim-ansible-yaml'
Plug 'hashivim/vim-terraform'
Plug 'saltstack/salt-vim'

" Python
Plug 'zchee/deoplete-jedi'

" Javascript / node.js plugins
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/javascript-libraries-syntax.vim' " Add syntax for js plugins (jquery, etc...)
Plug 'leafgarland/typescript-vim' " Add syntax for typescript
Plug 'maksimr/vim-jsbeautify' " Add front (js, json, html, css) formatting
Plug 'posva/vim-vue' "Add Vue.js support

" Go Plugin
Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'nsf/gocode'
Plug 'jodosha/vim-godebug'

" Markdown plugin
" Plug 'suan/vim-instant-markdown', {'do': 'sudo npm install -g instant-markdown-d'}

" Raml support
Plug 'IN3D/vim-raml'

" Tmux Integration
Plug 'tmux-plugins/vim-tmux-focus-events'

" File icons
Plug 'ryanoasis/vim-devicons'

" Add plugins to &runtimepath
call plug#end()

syntax on
filetype plugin indent on

set noerrorbells
set number
set backspace=indent,eol,start

set noswapfile
set nobackup
set nowritebackup
set splitright
set splitbelow

set foldmethod=syntax
set foldlevel=20

" Add number margin "
set number

" Make backspace work like most other apps
set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab

set background=dark
let g:solarized_termtrans=1
colorscheme solarized

" Removing trailing whitespaces every write operations
autocmd BufWritePre * %s/\s\+$//e

" Vim Airline configuration "
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'

" Set F6 to switch brackground color "
map <F6> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

map <F3> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <C-N> :CtrlPTag<CR>

" Changing split navigations shortcuts "
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Oceanic Next config

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" syntastic config "
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=1
let g:syntastic_aggregate_errors=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_ballons=has('ballon_eval')
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_ignore_files = ['^/usr/', '*node_modules*', '*vendor*', '*build*', '*LOCAL*', '*BASE', '*REMOTE*']
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_typescript_checkers=["tslint"]
let g:syntastic_go_checkers = ['golint', 'errcheck', 'go', 'go vet']
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_python_checkers=['flake8', 'pep8', 'python']
let g:syntastic_html_checkers=['jshint', 'HTMLHint']
let g:syntastic_yaml_checkers=['jsyaml']
let g:syntastic_sh_checkers=['sh', 'shellcheck', 'checkbashisms']
let g:syntastic_c_remove_include_errors=1
let g:syntastic_quiet_messages = { "level": "[]", "file": ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }
let g:syntastic_stl_format = '[%E{E: %fe #%e}%B{, }%W{W: %fw #%w}]'
let g:syntastic_java_javac_options = "-g:none -source 8 -Xmaxerrs 5 -Xmaswarns 5"
let g:syntastic_typescript_tslint_args = "--config ~/.vim/tslint.json"

"You Complete me configuration
" let g:ycm_python_binary_path = 'python'

" JSLINT fix, please comment this line if your node bin is nodejs instead of
" node.
let $JS_CMD='node'

" Deoplete for Neovim
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

  " Use partial fuzzy matches like YouCompleteMe
  call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#source('_', 'converters', ['converter_remove_paren'])
  call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif               " Close preview buffer once completion done.
endif

"Easy tag configuration
set tags=./.git/tags;
let g:easytags_dynamic_files = 1
let g:easytags_async = 1
let g:easytags_suppress_ctags_warning = 1

" NERDTree config
let NERDTreeHijackNetrw=1
let NERDTreeIgnore=['\.pyc$', '__pycache__']

" Coffeescript configuration
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Iterm2 configuration. Feel free to comment this section.
" Change the cursor display on Insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:instant_markdown_autostart = 0
