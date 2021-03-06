call plug#begin('~/.vim/plugged')

Plug 'dylanaraps/wal.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
" Plug 'itchyny/vim-gitbranch'
Plug 'tpope/vim-fugitive'
Plug 'raimondi/delimitmate'
Plug 'alvan/vim-closetag'
Plug 'jonsmithers/vim-html-template-literals' 

call plug#end()

let g:closetag_filetypes = 'html,xhtml,phtml,javascript,typescript'
let g:closetag_regions = {
      \ 'javascript':     'litHtmlRegion',
      \ 'typescript':     'litHtmlRegion',
      \ }
" set path=.,src,node_nodules

set termguicolors
set background=dark
" colorscheme wal 
" let g:solarized_termcolors=256
colorscheme solarized8
" let g:solarized_termtrans = 1

set listchars=tab:→\ ,trail:─,extends:❭,precedes:❬,nbsp:+
set fillchars=vert:┃,fold:-
set signcolumn=yes

set timeoutlen=1000 ttimeoutlen=100
set autowriteall
set encoding=UTF-8

" Show the line number on the bar
set ruler

" Line numbers
set number

" Necesary  for lots of cool vim things
set nocp

" This shows what you are typing as a command
set showcmd

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable

" Tab completion
set wildmenu
set wildmode=list:longest,full

" Incremental searching
set incsearch

" Highlight search
set hlsearch

let g:fzf_command_prefix = 'Fzf'
let g:coc_global_extensions = [
            \ 'coc-tsserver', 
            \ 'coc-tslint-plugin', 
            \ 'coc-emmet', 
            \ 'coc-snippets', 
            \ 'coc-highlight', 
            \ 'coc-lists', 
            \ 'coc-tabnine', 
            \ 'coc-html', 
            \ 'coc-css', 
            \ 'coc-yank']      

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

nnoremap <silent><Leader>o :FzfFiles<CR>
nnoremap <silent><Leader>O :FzfFiles!<CR>
nnoremap <silent><Leader>t :FzfTags<CR>
nnoremap <silent><Leader>s :FzfAg<CR>
nnoremap <silent><Leader><Space> :FzfGTags<CR>
nnoremap <silent>; :FzfBuffers<CR>
nnoremap <silent><Leader>n :NERDTreeToggle<CR>
nnoremap <silent><CR> :noh<CR>

" Coc Config
set cmdheight=2
set updatetime=300
set signcolumn=yes
set nobackup
set nowritebackup
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

vmap <silent><Leader>z :CocFix<CR>
nmap <silent><Leader>z :CocFix<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocActionAsync('runCommand', 'tsserver.format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocActionAsync('runCommand', 'tsserver.organizeImports')
command! -nargs=0 FX   :call CocActionAsync('runCommand', 'tsserver.executeAutofix')
" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> <space>f  :CocAction quickfix <CR>
nnoremap <silent> <space>q  :FX<CR>

" display lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'gitbranch': 'fugitive#name',
      \   'filetype': 'Filetype',
      \   'fileformat': 'Fileformat'
      \ },
      \ }

function! Filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! Fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

set title
set laststatus=2
set noshowmode

" Tab space
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
