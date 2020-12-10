" inspiration from https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L151-L187
let g:python_host_prog='/usr/bin/python2'
let g:mapleader = "\<Space>"

" Autoinstall vim-plug {{{
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'

" Appearance
" ====================================================================
Plug 'nanotech/jellybeans.vim'

Plug 'itchyny/lightline.vim'

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

" Easy Typing 
" ====================================================================
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround'

Plug 'junegunn/vim-easy-align'

Plug 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_vim_checkers          = ['vint']
  let g:syntastic_elixir_checkers       = ['elixir']
  let g:syntastic_python_checkers       = ['pylint']
  let g:syntastic_javascript_checkers   = ['eslint']


" Code Checking 
" ====================================================================
Plug 'neoclide/coc.nvim', {'branch':'release'}

call plug#end()
