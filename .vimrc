call plug#begin('~/.vim/plugged')
" Vim look
Plug 'flazz/vim-colorschemes' " vim colors
Plug 'chriskempson/base16-vim' " Base16 colors
Plug 'yggdroot/indentline' " Displays line for indentation
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhartington/oceanic-next'

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

" Code completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --tern-completer; sudo npm install -g typescript' }

" Devops tools
Plug 'b4b4r07/vim-hcl' " Hashicorp file syntax
Plug 'stephpy/vim-yaml' " Better yaml syntax
Plug 'chase/vim-ansible-yaml'
Plug 'rodjek/vim-puppet'

" Javascript / node.js plugins
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'moll/vim-node'
Plug 'kchmck/vim-coffee-script'
Plug 'Slava/tern-meteor' " Auto completion for meteor.
Plug 'othree/javascript-libraries-syntax.vim' " Add syntax for js plugins (jquery, etc...)
Plug 'leafgarland/typescript-vim' " Add syntax for typescript
Plug 'maksimr/vim-jsbeautify' " Add front (js, json, html, css) formatting

" Markdown plugin
Plug 'suan/vim-instant-markdown', {'do': 'sudo npm install -g instant-markdown-d'}

" Tmux Integration
Plug 'tmux-plugins/vim-tmux-focus-events'

" File icons
Plug 'ryanoasis/vim-devicons'


" Add plugins to &runtimepath
call plug#end()

" Vim configuration
set t_Co=256
syntax on
filetype plugin indent on
colorscheme OceanicNext

" Activate folding
set foldmethod=syntax
set foldlevel=20

set guifont=SourceCodePro\ Nerd\ Font\ Medium:h10


set background=dark

" Add number margin "
set number

" Make backspace work like most other apps
set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab

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
let g:syntastic_json_checkers=['jsonlint', 'jsonval']
let g:syntastic_python_checkers=['flake8', 'python']
let g:syntastic_html_checkers=['jshint', 'HTMLHint']
let g:syntastic_yaml_checkers=['jsyaml']
let g:syntastic_sh_checkers=['sh', 'shellcheck', 'checkbashisms']
let g:syntastic_c_remove_include_errors=1
let g:syntastic_quiet_messages = { "level": "[]", "file": ['*_LOCAL_*', '*_BASE_*', '*_REMOTE_*']  }
let g:syntastic_stl_format = '[%E{E: %fe #%e}%B{, }%W{W: %fw #%w}]'
let g:syntastic_java_javac_options = "-g:none -source 8 -Xmaxerrs 5 -Xmaswarns 5"
let g:syntastic_typescript_tslint_args = "--config ~/.vim/tslint.json"

"You Complete me configuration
let g:ycm_python_binary_path = 'python'

" JSLINT fix, please comment this line if your node bin is nodejs instead of
" node.
let $JS_CMD='node'

"Easy tag configuration
set tags=./.git/tags;
let g:easytags_dynamic_files = 1
let g:easytags_async = 1


" Coffeescript configuration
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Iterm2 configuration. Feel free to comment this section.
" Change the cursor display on Insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
