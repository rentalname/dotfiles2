set nocompatible
"set fileformat
set fileencoding=utf-8
set fileformat=unix
set fileformats=unix,dos

function! s:set_fileformat()
  try
    setlocal fileformat=unix
  catch
  endtry
endfunction
autocmd BufRead * :call <SID>set_fileformat()
autocmd BufNewFile * :call <SID>set_fileformat()

"Set colorscheme
"{{{
if !has("gui_running")
  set t_Co=256
endif
set background=dark
"}}}

"set transparency
"{{{
if has('kaoriya')
  set transparency=20
endif
"}}}

"User Setting Sequence
"{{{
set nobackup
set noswapfile
set number
set clipboard+=unnamed
set textwidth=118
set whichwrap=b,s,h,s,<,>,[,]
"set statusline=✘╹◡╹✘
"set statusline+=[%F]
"set statusline+=[%Y]
"set statusline+=[%{&fileencoding}]
"set statusline+=[%{&fileformat}]
set splitbelow
set splitright
set scrolloff=5
"インデント設定
set autoindent
"タブ幅の設定
set tabstop=4
set shiftwidth=2
set expandtab
set softtabstop=0
"制御コードを表示する
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"undoファイルを一カ所にまとめる
set undodir=$HOME."/.vim/undo"
" 全角スペースを表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
au BufRead,BufNew * match ZenkakuSpace /　/
" change map leader character
if has('gui_macvim')
  let mapleader = "_"
endif
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" カラースキームを設定する
let scheme = 'peaksea'
augroup gui_color_scheme
  au!
  execute 'autocmd GUIEnter * colorscheme' scheme
  set background=dark
augroup END
" Rails file association
augroup RubyOnRails
  au!
  au FileType ruby :set nowrap tabstop=2 tw=0 sw=2
  au BufNewFile *.rb set ft=ruby fenc=utf-8
  au FileType eruby :set nowrap tabstop=2 tw=2 sw=2
  au BufNewFile *.html.erb set filetype=eruby fenc=utf-8
  au BufNewFile,BufRead *.erb set ft=eruby.html fenc=utf-8
augroup END
if !has('gui_running')
  autocmd RubyOnRails
endif
"}}}

" User Key Mapping
"{{{
nnoremap <C-h>    <C-w>h
nnoremap <C-l>    <C-w>l
nnoremap <C-j>    <C-w>j
nnoremap <C-k>    <C-w>k
inoremap <C-UP>   <C-w>h
nnoremap <C-UP>   <C-w>h
inoremap <C-DOWN> <C-w>l
nnoremap <C-DOWN> <C-w>l
nmap <Esc><Esc> :nohlsearch<CR>
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>
"Load .gvimrc afterv.vimrc edited at GVim.
" Set augroup.
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>
" ---  ファイラーを起動 ---
nnoremap <silent><Space>j    :Explore<CR>
" 前のバッファ、次のバッファ、バッファの削除、バッファのリスト
nnoremap <silent><Space>b    :bp<CR>
nnoremap <silent><Space>n    :bn<CR>
nnoremap <silent><Space>k    :bd<CR>
nnoremap <Space>o    <C-W>o               " カーソルのあるウインドウを最大化する
nnoremap <silent><Space>h    :hide<CR>    " カーソルのあるウインドウを隠す
nnoremap <silent><Space>l    :ls<CR>
" ファイル保存：バッファ変更時のみ保存
nnoremap <silent><Space>s    :<C-u>update<CR>

" User Function Setting
"{{{

"!open firefox
command! OpenFire execute ":!open -a firefox %"
"}}}

"open browser
"{{{
command! OpenBrowserCurrent execute "OpenBrowser" expand("%:p")
"}}}



"NeoBundle
"{{{
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" After install, turn shell $VIM/vimfiles/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc', {
  \'build':{
    \'unix':'make -f make_unix.mak',
    \'mac':'make -f make_mac.mak',
  \},
\}
NeoBundleFetch 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimshell'
" Original repos on github
"NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'basyura/unite-rails'
NeoBundle 'bling/vim-airline'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'dougireton/vim-chef'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'lunaru/vim-less'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'michalliu/sourcebeautify.vim', { 'depends' : ['michalliu/jsruntime.vim', 'michalliu/jsoncodecs.vim'] }
NeoBundle 'mitchellh/vagrant'
NeoBundle 'mklabs/grunt.vim'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'othree/html5.vim'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'rizzatti/dash.vim'
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
NeoBundle 'ryuzee/neosnippet_chef_recipe_snippet'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'szw/vim-tags'
NeoBundle 'tell-k/vim-browsereload-mac'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-template'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-font'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'wikimatze/hammer.vim'
NeoBundle 'wincent/command-t'
" vim-scripts repos
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'PreserveNoEOL'
" Non github repos
" Non git repos
"NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
" gist repos
"'git://gist.github.com/187578.git', {'directory': 'h2u_white'}

call neobundle#end()

" Required:
filetype plugin indent on
" Installation check.
NeoBundleCheck
"}}}

"neocomplete
"{{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'coffee' : $HOME.'/.vim/dict/coffee.dict',
  \ 'eruby' : $HOME.'/.vim/dict/eruby.dict',
  \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
  \ 'rails' : $HOME.'/.vim/dict/rails.dict',
  \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
  \ 'sass' : $HOME.'/.vim/dict/sass.dict',
  \ 'scss' : $HOME.'/.vim/dict/scss.dict',
  \ 'vimshell' : $HOME.'/.vimshell_hist'
  \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" Enable omni completion.
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\|[@!]'
"}}}

"NeoSnipet
"{{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}

"AlpacaRailsSupport
"{{{
" `:RSCreateRoutesCache`
" inoremap <expr><C-X><C-R> neocomplete#start_manual_complete('rails/url_helper')
"}}}

"NERDTree
"{{{
autocmd VimEnter * NERDTree
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" バッファ切り替え
nmap [space]n :<C-U>bnext<CR>
nmap [space]p :<C-U>bprevious<CR>
nnoremap <Leader>1   :e #1<CR>
nnoremap <Leader>2   :e #2<CR>
nnoremap <Leader>3   :e #3<CR>
nnoremap <Leader>4   :e #4<CR>
nnoremap <Leader>5   :e #5<CR>
nnoremap <Leader>6   :e #6<CR>
nnoremap <Leader>7   :e #7<CR>
nnoremap <Leader>8   :e #8<CR>
nnoremap <Leader>9   :e #9<CR>
" バッファ一覧
nmap ,b :buffers<CR>
" 表示/非表示を切替
nmap nt :NERDTreeToggle<CR>
" リフレッシュ
nmap <F5> :NERDTree<CR>
"}}}

"quickrun
"{{{
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
  \ 'type': 'markdown/kramdown',
  \ 'outputter': 'browser'
\}
let g:quickrun_config['scss.css']={ 'type': 'scss'}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
let g:quickrun_config._ = {'runner' : 'vimproc'}

" rspecを実行するための設定を定義する
" %cはcommandに設定した値に置換される
" %oはcmdoptに設定した値に置換される
" %sはソースファイル名に置換される
let g:quickrun_config['ruby.rspec'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'outputter': 'buffered:target=buffer',
  \ 'exec': 'bundle exec %c %o --color --drb --tty %s'
  \}
"}}}

"vimshell
"{{{
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USERNAME."% "
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>
"}}}

"unite-outline
"{{{
nnoremap <silent> <Leader>o :<C-u>Unite -vertical -no-quit outline<CR>
"}}}
"

"vim-browsereload-mac
"{{{
let g:returnApp = "MacVim"
nmap <Space>bc :ChromeReloadStart<CR>
nmap <Space>bC :ChromeReloadStop<CR>
nmap <Space>bf :FirefoxReloadStart<CR>
nmap <Space>bF :FirefoxReloadStop<CR>
nmap <Space>bs :SafariReloadStart<CR>
nmap <Space>bS :SafariReloadStop<CR>
nmap <Space>ba :AllBrowserReloadStart<CR>
nmap <Space>bA :AllBrowserReloadStop<CR>
"}}}

"indentLine
"{{{
let g:indentLine_color_gui = '#606060'
"let g:indentLine_color_tty_light = 7
"let g:indentLine_color_dark = 4
let g:indentLine_char = ':'
let g:indentLine_indent_level = 5

"}}}

"emmet.vim
"{{{
"}}}

"set vim-rails
"{{{
"  noremap <C-1> RDmodel<CR>
"  noremap <C-2> REcontroller<CR>
"  noremap <C-3> RDview<CR>
"}}}

"vim-coffee-script
"{{{
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
"}}}

"Unite rails
"{{{
nnoremap <F1> :Unite rails/model<CR>
inoremap <F1> <Esc><F1>
nnoremap <F2> :Unite rails/view<CR>
inoremap <F2> <Esc><F2>
nnoremap <F3> :Unite rails/controller<CR>
inoremap <F3> <Esc><F3>
nnoremap <F4> :Unite rails/helper<CR>
inoremap <F4> <Esc><F4>
nnoremap <F5> :Unite rails/stylesheet<CR>
inoremap <F5> <Esc><F5>
nnoremap <F6> :Unite rails/javascript<CR>
inoremap <F6> <Esc><F6>
nnoremap <F7> :Unite rails/spec
inoremap <F7> <Esc><F7>
nnoremap <F9> :Unite rails/route<CR>
"}}}

"Ctags
"{{{
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"
nnoremap <C-TAB> :tab stj<CR>
"}}}

"Syntastic
"{{{
let g:syntastic_quiet_messages={"type":"syntax", "regex": 'unreadable: compass'}
"}}}

"set over.vim
"{{{
" 0 以外が設定されていれば :/ or :? 時にそのパータンをハイライトする。
let g:over#command_line#search#enable_incsearch = 1
" 0 以外が設定されていれば :/ or :? 時にそのパータンへカーソルを移動する。
let g:over#command_line#search#enable_move_cursor = 1
"}}}

"set PreserveNoEOL
"{{{
let b:PreserveNoEOL=1
"}}}
