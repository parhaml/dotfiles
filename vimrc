set encoding=utf-8

" Leader
let mapleader = " "

call plug#begin('~/.vim/plugged')

Plug 'dense-analysis/ale'
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'chun-yang/auto-pairs'
Plug 'tkatsu/vim-erblint'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-endwise'
call plug#end()

nnoremap <SPACE> <Nop>
let mapleader=" "
set clipboard=unnamed
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set relativenumber " Line numbers!!!
set number

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Switch syntax highlighting on, when the terminal has colors
color onedark

" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
augroup END

autocmd FileType ruby nnoremap<buffer> <leader>wtf Orequire "pry";binding.pry
autocmd FileType javascript nnoremap<buffer> <leader>wtf Odebugger;
autocmd FileType vue nnoremap<buffer> <leader>wtf Odebugger;

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Better splits
set splitbelow
set splitright

" these 'Ctrl mappings' work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
    endif
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>

highlight ALEWarning ctermbg=DarkRed

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

if executable('rg')
  " ack.vim --- {{{

  " Use ripgrep for searching ⚡️
  " Options include:
  " --vimgrep -> Needed to parse the rg response properly for ack.vim
  " --type-not sql -> Avoid huge sql file dumps as it slows down the search
  " --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
  let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

  " Auto close the Quickfix list after pressing '<enter>' on a list item
  let g:ack_autoclose = 1

  " Any empty ack search will search for the work the cursor is on
  let g:ack_use_cword_for_empty_search = 1

  " Don't jump to first match
  cnoreabbrev Ack Ack!

  " Maps <leader>/ so we're ready to type the search keyword
  nnoremap <Leader>/ :Ack!<Space>
  " }}}

  " Navigate quickfix list with ease
  nnoremap <silent> [q :cprevious<CR>
  nnoremap <silent> ]q :cnext<CR>
endif

" NERDTree better width
let g:NERDTreeWinSize=50
