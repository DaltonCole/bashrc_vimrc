"### Configurations ###
set pastetoggle=<F2>
" Allow cursor to wrap to next and previous line
set whichwrap+=<,>,h,l,[,]
" Set cursor to the middle of the screen
:set scrolloff=999
" Tab 4 spaces
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

""" Spellcheck """
set spelllang=en
set spell
" Toggle / Untoggle spell checking using ,ss
map <leader>st :setlocal spell!<cr>
" Next spelling error
map <leader>sn ]s
" Previous spelling error
map <leader>sp [s
" Add word to dictionary
map <leader>sa zg
" Spell check
map <leader>ss z=

" Disable folding
set nofoldenable
" How many lines of history vim has to remember
set history=1000
" Enable filetype plugins
filetype plugin on
filetype indent on

" Auto read file changes (when changed from outside)
set autoread
au FocusGained,BufEnter * checktime

" Use :W to sudo save file
command! W executes 'w !sudo tee % > /dev/null' <bar> edit!

" Always center cursor vertically
set scrolloff=999

" Menu for auto complete
set wildmenu
set wildignore=*.o,*~,*.pyc " Ignore compiled files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Show current position
set ruler

" Height of the command bar
set cmdheight=1

" Hide the buffer when it is abandoned
set hid

" Make backspace act like it should
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Searching
set ignorecase " Ignore case
set smartcase  " Be smart about cases
set hlsearch   " Highlight search results
set incsearch  " Search while typing
set magic      " Use regular expressions in search
" Space to search
map <space> /
" Use Ctrl-Space to backwards search
map <C-space> ? 

" Don't redraw while executing macros
set lazyredraw

" Show matching bracket when hovered
set showmatch
set mat=2  " Blink rate for matching bracket

" No annoying sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""" Colors and Fonts """
"Enable syntax highlighting
syntax enable

" Enable 256 color palette
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Encodings
set encoding=utf8
" Standard file type to Unix
set ffs=unix,dos,mac

" Backups - backup current file, deleted afterwards (default)
set nobackup
set writebackup

""" Indention """
set expandtab  " Use spaces instead of tabs
set smarttab   " Auto tab to the correct spot on new lines
set shiftwidth=4 " 1 tab = 4 spaces
set tabstop=4    " 1 tab = 4 spaces
set ai    " Auto indent - Copy previous indent layer
set si    " Smart indent - Be smart about auto intenting
set wrap  " Wrap lines that go off screen

""" Moving Around """
" Move between windows using Ctrl+jkhl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" 0 goes to first non-blank character
" map 0 ^


""" Leader Stuff """
" Set leader
let mapleader = ","


""" Status Line """
" Always show the status line
set laststatus=2
" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c " Overwritten by air-line

""" Left Column """
"set number
"set relativenumber
" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
set signcolumn=number " Vim can merge signcolumn and number column into one

""" Save """
" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

""" Other """
set updatetime=300 " Update swap file after 300 ms of idle time
set shortmess+=c  " Ignore some "Have to hit enter" options (TODO: Further explore)



"### Plugins ###
call plug#begin('~/.nvim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Nerd tree - Show directories
Plug 'scrooloose/nerdtree'

" YouCompleteMe - Autocompletion
"Plug 'valloric/youcompleteme'
"let g:ycm_enable_diagnostic_signs = 0
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_show_diagnostics_ui = 0
"let g:ycm_echo_current_diagnostic = 0
"let g:ycm_key_list_select_completion = ['<TAB>']
"let g:ycm_key_list_previous_completion = ['<S-TAB>']
"let g:ycm_key_list_stop_completion = ['<C-y>', '<Up>', '<Down>']
"let g:ycm_autoclose_preview_window_after_insertion = 1
"set splitbelow
"" Youcompleteme, close preview window automatically
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"" Disable Youcompleteme with python
""let g:ycm_filetype_blacklist = {'python': 1}
""let g:yvm_semantic_triggers = {'python': []}

" Colorful Parenthesis
Plug 'luochen1990/rainbow'

""" HTML """
" Emmet
" * `,,` is the way to run command in insert-mode
" * HTML Boilerplate: `html:5,,''`
" * Create a tag: `div,,`, `p,,`, etc.
" * Child tags: `div>p>a,,` Will exapand to <div><p><a...
"   * To make many items in an item: `ul>li*5,,`
" * Use `.` for class and `#` for id: `div.container>p#foo>a,,`
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
" Close tags via `>`
"   Use `>>` to put close tag on new line
Plug 'alvan/vim-closetag'

" Python-Mode
" * Run Code: <leader>r
" * Add/Remove Break Point: <leader>b
" * Search Documentation: <leader>K
" * HELP: `:help pymode`
Plug 'klen/python-mode'
let g:pymode_lint = 1
let g:pymode_lint_on_write = 1
"autocmd FileType python setlocal nonumber
let g:pymode_lint_ignore = ["E501", "E402"]  " Ignore: Line length limit, module import not at top of file
let g:pymode_lint_cwindow = 0  " Do not open preview window for PEP errors
let g:pymode_options_colorcolumn = 0  " No colored column at max line length
let g:pymode_indent = 1  " PEP8-Compatible python indent
let g:pymode_doc = 1  " Show pydoc documentation
"let g:pymode_options_max_line_length = 120
"let g:pymode_lint_ignore = "E501"
"let g:pep8_ignore="E501"
"let g:pymode_lint_options_pep8 = {'max_line_length': 120}
"let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:pymode_trim_whitespaces = 1  "Trim unused white space at end of lines

" Grammar Check
" * To Run: `:GrammarousCheck`
" * Local mappings from the information window:
"   * Quit window: `q`
"   * Move to location of the error: `<Ctrl>`
"   * Fix the error automatically: `f`
"   * Mote to next/previous: `n`/`p`
Plug 'rhysd/vim-grammarous'

" Pretty break indention
set breakindent

" Javascript
Plug 'pangloss/vim-javascript'
let g:javascript_plugin_jsdoc = 1 " Syntax highlighting
let g:javascript_plugin_flow = 1 " Flow syntax highlighting

" Linter
Plug 'dense-analysis/ale'
let g:ale_linters = {'rust': ['analyzer']} " Rust support

""" Coc.nvim (Auto Complete) """
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Find coc config files at: https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> (i.e. Enter) auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region. (TODO: CodeAction??)
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'junegunn/fzf'
set hidden " Required for operations modifying multiple buffers like rename.

""" END COC """

""" Rust """
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }
Plug 'neovim/nvim-lspconfig'

""""""

" Colorscheme
Plug 'crucerucalin/peaksea.vim'
set background=dark
colorscheme peaksea

" Status bar
Plug 'vim-airline/vim-airline'
let g:airline#extensions#ale#enabled = 1  " Move errors to status bar


" Testing (TODO)
"Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'antoinemadec/FixCursorHold.nvim'
"Plug 'nvim-neotest/neotest'




" Initialize plugin system
call plug#end()

" Automatically install plugins
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
