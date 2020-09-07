"Something important
"When use this config file in a new machine
"first do :PlugInstall
"then do :checkhealth
"pay attention to warning part(you might have to install xclip and corret the
"python_path)

"Set the space as leader key
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
"set termguicolors
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"Change file encoding to uft-8
noremap <LEADER>ct :set fileencoding=utf-8<CR>:w<CR>

"Prevent incorrect background rendering
"let &t_ut=''

"Open the file at last edit position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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
"Set relativenumber
noremap <LEADER>NN :set nu<CR>:set relativenumber<CR>

" Open the vimrc file anytime
noremap <LEADER>ev :tabe ~/.config/nvim/init.vim<CR>

"Open the i3 config file anytime
noremap <LEADER>ei :tabe ~/.config/i3/config<CR>


"set cursorline
"set cursorcolumn
set wrap
set wildmenu
set showcmd
set hlsearch
set incsearch
set ignorecase
set smartcase
set shortmess+=c
set signcolumn=yes
set mouse=a
"copy to system clipboard
set clipboard+=unnamedplus

exec "nohlsearch"
set laststatus=2
let python_hightlight_all=1

"Better tab
set tabstop=4
set shiftwidth=4

"Some remap to make vim work better
"vnoremap Y "+y
noremap Y y$
noremap <LEADER>d 0D
noremap <LEADER>v v$
noremap <LEADER><CR> :nohlsearch<CR>
noremap S :w!<CR>
"noremap S :call IsSaved()<CR>
noremap Q :q<CR> 
noremap <LEADER>Q :q!<CR>
noremap <LEADER>R :source $MYVIMRC<CR>

func! IsSaved()
	if &modified[0] == 1
	  exec "w"
	else
	  echo "No Change"
	endif
endfunc

"map <LEADER>R :call CompileBuildrrr()<CR>
"func! CompileBuildrrr()
"  exec "w"
"  if &filetype == 'vim'
"    exec "source $MYVIMRC"
"  elseif &filetype == 'markdown'
"    exec "echo"
"  endif
"endfunc
"
noremap j gj
noremap k gk
noremap gj j
noremap gk k
map J 5j
map K 5k
noremap H ^
noremap L $

"SET SPELL
noremap <LEADER>S :set spell<CR>
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
"noremap <LEADER>srh <C-w>b<C-w>I
"noremap <LEADER>srv <C-w>b<C-w>H
" Tab
noremap tn :tabe<CR>
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

"Opening a terminal window below
noremap <LEADER>? :set splitbelow<CR>:sp<CR>:term<CR>
"Open a float terminal
noremap <LEADER>/ :FloatermNew<CR>
"Paste the current path in the end of current line
noremap <LEADER>pp :r !pwd<CR>kJ

"Paste the present date in the end of current line
noremap <LEADER>pd :r !echo $(date "+\%Y/\%m/\%d")<CR>kJ

"insert mode cursor movement
imap <C-j> <CR>
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
inoremap <C-k> <ESC>lC
inoremap <C-b> <LEFT>
inoremap <C-f> <RIGHT>

" Some floaterm short commands
command! Ranger FloatermNew ranger
command! NNN FloatermNew nnn

noremap \s :%s//g<left><left>

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
    :!time ruby %
  elseif &filetype == 'python'
    set splitbelow
    :split
    :res-10
    :term python3 %
  elseif &filetype == 'lua'
	:!time lua %
  elseif &filetype == 'javascript'
    :!time node %
  elseif &filetype == 'html'
    exec "!google-chrome-stable % &"
  elseif &filetype == 'php'
    exec "!google-chrome-stable % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc


"Solve the problem when input Chinese
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

"Some other userful map
"Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4l
"Run the current in the shell
noremap <LEADER>el :exec '!'.getline('.')<CR>
noremap <LEADER>m i<!-- more --><ESC>

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
"Plug 'theniceboy/eleline.vim'
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
Plug 'joelstrouts/swatch.vim'
Plug 'voldikss/vim-floaterm'

"File navigation
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
"Plug 'Xuyuanp/nerdtree-git-plugin'
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
"Plug 'mattn/emmet-vim'

"MarkDown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for' :['markdown', 'vim-plug'] }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'
Plug 'reedes/vim-pencil', { 'for' :['markdown', 'vim-plug'] }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

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

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"Plug 'terryma/vim-multiple-cursors'
Plug 'Chiel92/vim-autoformat'
Plug 'liuchengxu/vista.vim'
Plug 'godlygeek/tabular' 
"Plug 'lambdalisue/suda.vim'

"Dependencies

"other userful plug
Plug 'jiangmiao/auto-pairs'
Plug 'pechorin/any-jump.vim'

call plug#end()

" ===
" === Dress
" ===
"let g:space_vim_transp_bg = 1
"colorscheme space_vim_theme
colorscheme nord
"colorscheme wal
set background=dark

"===
"=== airline
"===
let g:airline_theme='wal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0

"===
"=== eleline
"===
"let g:airline_powerline_fonts = 0

"source /home/dreamlocker/.config/nvim/_machine_specific_default.vim

"===
"===Taglist
"===
map <LEADER>tg :Tlist<CR>
let Tlist_Use_Right_Window = 1

" ===
" === NERDTree
" ===
"map <LEADER>f  :NERDTreeToggle<CR>
""set the windows on the left
""let NERDTreeWinPos=1
"let NERDTreeMapOpenExpl = ""
"let NERDTreeMapUpdir = ""
"let NERDTreeMapUpdirKeepOpen = "l"
"let NERDTreeMapOpenSplit = ""
"let NERDTreeOpenVSplit = ""
"let NERDTreeMapActivateNode = "i"
"let NERDTreeMapOpenInTab = "o"
"let NERDTreeMapPreview = ""
"let NERDTreeMapCloseDir = "n"
"let NERDTreeMapChangeRoot = "y"

" ==
" == NERDTree-git
" ==
"let g:NERDTreeIndicatorMapCustom = {
    "\ "Modified"  : "✹",
    "\ "Staged"    : "✚",
    "\ "Untracked" : "✭",
    "\ "Renamed"   : "➜",
    "\ "Unmerged"  : "═",
    "\ "Deleted"   : "✖",
    "\ "Dirty"     : "✗",
    "\ "Clean"     : "✔︎",
    "\ "Unknown"   : "?"
    "\ }

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
let g:coc_global_extensions = [
	\ 'coc-python',
	\ 'coc-vimlsp',
	\ 'coc-snippets',
	\ 'coc-emmet', 
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-css',
	\ 'coc-tsserver',
	\ 'coc-yank',
	\ 'coc-lists',
	\ 'coc-gitignore',
	\ 'coc-explorer',
	\ 'coc-translator'
	\]

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
nmap <LEADER>f :CocCommand explorer<CR>
nmap <LEADER>ts <Plug>(coc-translator-p)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <LEADER>J :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"""
"""===emmet
"""
"let g:user_emmet_mode='n'

" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1

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

"===
"=== markdownhightlight
"===
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1   
let g:vim_markdown_new_list_item_indent=2

"===
"===vim-table-mode
"===
map <LEADER>tm :TableModeToggle<CR>

"===
"===FZF
"===
noremap <LEADER>F :FZF<CR>

" ===
" === Leaderf
" ===
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_PopupPalette = {
    \  'light': {
    \      'Lf_hl_match': {
    \                'gui': 'NONE',
    \                'font': 'NONE',
    \                'guifg': 'NONE',
    \                'guibg': '#303136',
    \                'cterm': 'NONE',
    \                'ctermfg': 'NONE',
    \                'ctermbg': '236'
    \              },
    \      'Lf_hl_cursorline': {
    \                'gui': 'NONE',
    \                'font': 'NONE',
    \                'guifg': 'NONE',
    \                'guibg': '#303136',
    \                'cterm': 'NONE',
    \                'ctermfg': 'NONE',
    \                'ctermbg': '236'
    \              },
    \      }
    \  }

"===
"===GitGutter
"===
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'

"autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap <LEADER>H :GitGutterPreviewHunk<CR>
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

"===
"=== floaterm
"===
let g:floaterm_position = 'bottomright'

"===
"=== any-jump
"===
let g:any_jump_disable_default_keybindings = 1
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9


"===
"=== tabular
"===
vmap <LEADER>ga :Tabularize /

"===
"=== vim-visual-multi
"===
let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
"let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
let g:VM_maps['Find Under']         = '<C-n>'
"let g:VM_maps['Find Subword Under'] = '<C-m>'

"===
"=== sudo.vim
"===
"let g:sudo#prefix = 'suda://'
"noremap <LEADER>w :w suda://%<CR>
"noremap <LEADER>ee :e suda://%<CR>
