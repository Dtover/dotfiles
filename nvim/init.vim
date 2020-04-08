"Something important
"When use this configure file in a new machine
"first do :PlugInstall
"then do :checkhealth
"pay attention to warning part(you might have to install xclip and corret the
"python_path)
"
let mapleader=" "

"===
"===System
"===
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set fileencoding=utf-8
set encoding=utf-8 
set termencoding=utf-8
set fileencodings=ucs,utf-8,cp936
"Change file encoding to uft-8
noremap <LEADER>ct :set fileencoding=utf-8<CR>:w<CR>

"Prevent incorrect background rendering
"let &t_ut=''

"source /home/dreamlocker/.config/nvim/_machine_specific_default.vim

set scrolloff=5
syntax on
set foldmethod=indent
set foldlevel=99
set nu
set relativenumber

" Folding
"noremap <silent> <LEADER>o za
"Set no number
noremap <LEADER>nn :set nonu<CR>:set norelativenumber<CR>
"Set number
noremap <LEADER>NN :set nu<CR>:set relativenumber<CR>

" Open the vimrc file anytime
noremap <LEADER>ev :tabe ~/.config/nvim/init.vim<CR>

"Open the i3 config file anytime
noremap <LEADER>ei :tabe ~/.config/i3/config<CR>


"set cursorline
set wrap
set wildmenu
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set shortmess+=c
set signcolumn=yes
"copy to system clipboard
set clipboard+=unnamedplus
"vnoremap Y "+y
noremap Y y$
noremap <LEADER>d 0D

noremap <LEADER>v v$

set mouse=a

exec "nohlsearch"
set laststatus=2
let python_hightlight_all=1

"Better tab
set tabstop=4
set shiftwidth=4

noremap <LEADER><CR> :nohlsearch<CR>
"noremap ; :
"noremap : ;
"noremap <LEADER>s <nop>
noremap S :w!<CR>
noremap Q :q<CR> 
noremap <LEADER>Q :q!<CR>
noremap <LEADER>R :source $MYVIMRC<CR>
"map <LEADER>R :call CompileBuildrrr()<CR>
"func! CompileBuildrrr()
"  exec "w"
"  if &filetype == 'vim'
"    exec "source $MYVIMRC"
"  elseif &filetype == 'markdown'
"    exec "echo"
"  endif
"endfunc


noremap J 5j
noremap K 5k
"noremap H 5h
"noremap L 5l

"SET SPELL
noremap <LEADER>ss :set spell<CR>
noremap <LEADER>sn :set nospell<CR>

"Windowsplit
noremap <LEADER>sh :vsplit<CR>
noremap <LEADER>sl :set splitright<CR>:vsplit<CR>
noremap <LEADER>sj :set splitbelow<CR>:split<CR>
noremap <LEADER>sk :set nosplitbelow<CR>:split<CR>
noremap <LEADER>h <C-w>h
noremap <LEADER>j <C-w>j
noremap <LEADER>k <C-w>k
noremap <LEADER>l <C-w>l
noremap <UP> :res+3<CR>
noremap <DOWN> :res-3<CR>
noremap <LEFT> :vertical res-5<CR>
noremap <RIGHT> :vertical res+5<CR>
"noremap srh <C-w>b<C-w>I
"noremap srv <C-w>b<C-w>H
"Tab
noremap tn :tabe<CR>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

"Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

"Paste the current path
noremap <LEADER>p :r !pwd<CR>kJ


"insert mode cursor movement
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" Compile function
noremap <LEADER>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cs'
    exec "!mcs % -out:%<.exe"
    exec "!mono ./%<.exe"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'perl'
    :!time perl %
  elseif &filetype == 'ruby'
    :!time perl %
  elseif &filetype == 'python'
    set splitbelow
    :split
    :res-10
    :term python3 %
  elseif &filetype == 'lua'
    :!time lua %
  elseif &filetype == 'html'
    exec "!google-chrome-stable % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc

"Solve the prolem when input Chinese
let g:input_toggle = 0
function! Fcitx2en()
let s:input_status = system("fcitx-remote")
if s:input_status == 2
let g:input_toggle = 1
let l:a = system("fcitx-remote -c")
endif
endfunction

function! Fcitx2zh()
let s:input_status = system("fcitx-remote")
if s:input_status != 2 && g:input_toggle == 1
let l:a = system("fcitx-remote -o")
let g:input_toggle = 0
endif
endfunction

set timeoutlen=1000
autocmd InsertLeave * call Fcitx2en()
autocmd InsertEnter * call Fcitx2zh()

"Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4l
"Press j twice to jump to the end of the line
"inoremap jj <ESC>A
"inoremap kk <ESC>/<++><CR>:nohlsearch<CR>c4l

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
"Plug 'bling/vim-bufferline'
Plug 'altercation/vim-colors-solarized'
Plug 'liuchengxu/space-vim-theme'
"Plug 'mg979/vim-xtabline'
Plug 'ryanoasis/vim-devicons'
Plug 'dylanaraps/wal.vim'
Plug 'mhinz/vim-startify'
Plug 'bagrat/vim-buffet'
Plug 'arcticicestudio/nord-vim'

"File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
"Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mcchrish/nnn.vim'

"Git
Plug 'fszymanski/fzf-gitignore', {'do': ':UpdateRemotePlugins'}

"HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'mattn/emmet-vim'

"MarkDown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for' :['markdown', 'vim-plug'] }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'
Plug 'reedes/vim-pencil', { 'for' :['markdown', 'vim-plug'] }

"AutComplicted
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'SirVer/ulnisnips'
Plug 'honza/vim-snippets'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-github'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-match-highlight'

"Language Server

"language check
"Plug 'scrooloose/syntastic'

Plug 'junegunn/goyo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'Chiel92/vim-autoformat'
Plug 'liuchengxu/vista.vim'


"Dependencies
"other userful plug
Plug 'jiangmiao/auto-pairs'

call plug#end()

" ===
" === Dress
" ===
"let g:space_vim_transp_bg = 1
"colorscheme space_vim_theme
"colorscheme nord
colorscheme wal
set background=dark

"===
"=== airline
"===
let g:airline_theme='wal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#buffer_idx_mode = 1
"nmap <leader>1 <Plug>AirlineSelectTab1
"nmap <leader>2 <Plug>AirlineSelectTab2
"nmap <leader>3 <Plug>AirlineSelectTab3
"nmap <leader>4 <Plug>AirlineSelectTab4
"nmap <leader>5 <Plug>AirlineSelectTab5
"nmap <leader>6 <Plug>AirlineSelectTab6
"nmap <leader>7 <Plug>AirlineSelectTab7
"nmap <leader>8 <Plug>AirlineSelectTab8
"nmap <leader>9 <Plug>AirlineSelectTab9


"source /home/dreamlocker/.config/nvim/_machine_specific_default.vim

"===
"===Taglist
"===
map <LEADER>tg :Tlist<CR>
let Tlist_Use_Right_Window = 1

" ===
" === NERDTree
" ===
map <LEADER>f  :NERDTreeToggle<CR>
"set the windows on the left
"let NERDTreeWinPos=1
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "l"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

" ==
" == NERDTree-git
" ==
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" ===
" === coc
" ===
" fix the most annoying bug that coc has
"autocmd WinEnter * call timer_start(1000, { tid -> execute('unmap if')})
"silent! autocmd BufEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
"silent! autocmd WinEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
silent! au BufEnter * silent! unmap if
"au TextChangedI * GitGutter
" Installing plugins
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-snippets', 'coc-emmet', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-explorer', 'coc-translator']
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Useful commands
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <LEADER>tt :CocCommand explorer<CR>
" coc-translator
nmap <LEADER>ts <Plug>(coc-translator-p)

"""
"""===emmet
"""
let g:user_emmet_mode='n'

"""
"""===pydiction
"""
"let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
"let g:pydiction_menu_height = 5 
"" complete menu
"hi Pmenu       ctermfg=green  ctermbg=black guifg=#66D9EF  guibg=#000000
"hi PmenuSel    ctermfg=green  ctermbg=black                guibg=#808080
"hi PmenuSbar                                               guibg=#080808
"hi PmenuThumb                               guifg=#66D9EF

" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1

"" ===
"" ===syntastic
"" ===
"set signcolumn=yes
"highlight SyntasticErrorSign guifg=white guibg=black
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'firefox'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

source ~/.config/nvim/md-snippets.vim

"
"===markdownhighlight
"
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1   
let g:vim_markdown_new_list_item_indent=2

"===
"===vim-table-mode
"===
map <LEADER>tm :TableModeToggle<CR>
"===
"===Goyo
"===
noremap gy :Goyo<CR>


"===
"===FZF
"===
noremap <LEADER>F :FZF<CR>


"===
"===GitGutter
"===
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
"highlight SignColumn ctermbg=black

autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>
"source /home/dreamlocker/.config/nvim/pack/airblade/start/vim-gitgutter/unplace.vim

"===
"===Ultisnips
"===
inoremap <c-p> <nop>
inoremap <c-n> <nop>
let g:UltiSnipsExpandTrigger="<c-n>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips/', 'UltiSnips']

" ==
" == vim-multiple-cursor
" ==
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"===
"=== xtabline
"===
"let g:xtabline_settings = {}
"let g:xtabline_settings.enable_mappings = 0
"let g:xtabline_settings.tabline_mode = ['tabs', 'buffers']
"let g:xtabline_settings.enable_persistance = 0
"let g:xtabline_settings.last_open_first = 1
"noremap <LEADER>to :XTabCycleMode<CR>
"noremap \p : XTabInfo<CR>

"===
"=== Vista.vim
"===
noremap <LEADER>T :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"===
"=== vim-ctrlspace
"===
"let g:CtrlSpaceDefaultMappingKey = "<C-space> "
"function! StartifyEntryFormat()
	"return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
"endfunction

"===
"=== vim-buffet
"===
let g:buffet_powerline_separators = 1
let g:buffet_always_show_tabline = 1
let g:buffet_show_index = 1
let g:buffet_tab_icon = "Tab"
function! g:BuffetSetCustomColors()
    hi! BuffetCurrentBuffer cterm=NONE ctermbg=0 ctermfg=6 
    hi! BuffetBuffer cterm=NONE ctermbg=0 ctermfg=1
    hi! BuffetActiveBuffer cterm=NONE ctermbg=8 ctermfg=7
	hi! BuffetTrunc cterm=NONE
	hi! BuffetTab cterm=NONE ctermfg=3 ctermfg=0
endfunction

nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

"===
"=== vim-pencil
"===
let g:pencil#autoformat = 1
let g:pencil#wrapModeDefault = 'soft' 
