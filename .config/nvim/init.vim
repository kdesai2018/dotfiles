let mapleader = ','
" inspiration from https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L151-L187
call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'

" Appearance
" ====================================================================
Plug 'itchyny/lightline.vim'

" vim-fugitive for git integration with lightline
Plug 'tpope/vim-fugitive'

Plug 'owickstrom/vim-colors-paramount'
" File Search 
" ====================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeHijackNetrw = 0
  let g:NERDTreeWinSize = 31
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeCascadeOpenSingleChildDir = 1

  map <C-o> :NERDTreeToggle<CR>

Plug 'preservim/nerdcommenter'
" Easy Typing 
" ====================================================================
Plug 'jiangmiao/auto-pairs'
"Plug 'tpope/vim-endwise'
"Plug 'rstacruz/vim-closer'

Plug 'tpope/vim-surround'

"Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/syntastic'
let g:syntastic_vim_checkers          = ['vint']
let g:syntastic_elixir_checkers       = ['elixir']
let g:syntastic_python_checkers       = ['pylint']
let g:syntastic_javascript_checkers   = ['eslint']


" Code Checking 
" ====================================================================
Plug 'neoclide/coc.nvim', {'branch':'release'}

call plug#end()


" Basic functions
" ====================================================================

" status line commands
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['lineinfo'],
      \              [ 'percent' ],
      \              [ 'filetype' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }



" indenting
set tabstop=8
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set cindent

"" for junegunn/easy-align plugin
"xmap ga <Plug>(EasyAlign)
"nmap ga <Plug>(EasyAlign)

"Commenting
filetype plugin on

"Color 
" ====================================================================
colorscheme simple-dark 
