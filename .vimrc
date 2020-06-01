" FIRST TIME:
" For youcompleteme, make sure to run
" python3 ~./vim/bundle/youcompleteme/install.py



set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" The Ultimate vimrc
set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

let g:go_version_warning = 0
""""""""""""""""""""""
" Auto complete
Plugin 'valloric/youcompleteme'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_echo_current_diagnostic = 0
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<Up>', '<Down>']
let g:ycm_autoclose_preview_window_after_insertion = 1
set splitbelow
" Youcompleteme, close preview window automatically
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" Disable Youcompleteme with python
"let g:ycm_filetype_blacklist = {'python': 1}
"let g:yvm_semantic_triggers = {'python': []}

" Paste mode so no stupid auto formating when pasting
set pastetoggle=<F2>

" Allow cursor to wrap to next and previous line
set whichwrap+=<,>,h,l,[,]

" Set sursor to middle of the screen
:set scrolloff=999

" Tab 4 spaces
filetype plugin indent on
set tabstop=4
set softtabstop =4
set shiftwidth=4
set expandtab

" Spell check
set spelllang=en
set spell

" Python Debug
Plugin 'joonty/vdebug'

" Get rid of W12 warning
set autoread
autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

" NerdTree remap
let NERDTreeMapOpenInTab='f'

" JSON auto formatter
Plugin 'Chiel92/vim-autoformat'

" Colorful PARENTHESES! # HOW MAKE WORK???
Plugin 'luochen1990/rainbow'

" Kite - NOTE: Type shift-K to view documentation under cursor
"let g:lightline.component += %{kite#statusline()}
let g:kite_tab_complete=1 " Tab complete
set completeopt+=menuone   " show the popup menu even when there is only 1 match
"set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=longest   " don't insert the longest common text"
set completeopt+=preview   " Show documentation
autocmd CompleteDone * if !pumvisible() | pclose | endif " Preview window close automatically after insert
set belloff+=ctrlg  " if vim beeps during completion
"let g:kite_previous_placeholder = '<S-TAB>'
"let g:kite_next_placeholder = '<TAB>'
let g:kite_auto_complete = 1



