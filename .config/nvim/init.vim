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
" {{{
  let g:jellybeans_use_term_background_color = 0
" }}}
Plug 'itchyny/lightline.vim'
" {{{
  let g:lightline = {
        \ 'colorscheme': 'jellybeans',
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'gitgutter', 'filename' ] ],
        \   'right': [ [ 'percent', 'lineinfo' ],
        \              [ 'syntastic' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'LightLineFugitive',
        \   'gitgutter': 'LightLineGitGutter',
        \   'readonly': 'LightLineReadonly',
        \   'modified': 'LightLineModified',
        \   'syntastic': 'SyntasticStatuslineFlag',
        \   'filename': 'LightLineFilename'
        \ },
        \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
        \ 'subseparator': { 'left': '>', 'right': '' }
        \ }
  function! LightLineModified()
    if &filetype == "help"
      return ""
    elseif &modified
      return "+"
    elseif &modifiable
      return ""
    else
      return ""
    endif
  endfunction

  function! LightLineReadonly()
    if &filetype == "help"
      return ""
    elseif &readonly
      return "RO"
    else
      return ""
    endif
  endfunction

  function! LightLineFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction

  function! LightLineGitGutter()
    if ! exists('*GitGutterGetHunkSummary')
          \ || ! get(g:, 'gitgutter_enabled', 0)
          \ || winwidth('.') <= 90
      return ''
    endif
    let symbols = [
          \ g:gitgutter_sign_added,
          \ g:gitgutter_sign_modified,
          \ g:gitgutter_sign_removed
          \ ]
    let hunks = GitGutterGetHunkSummary()
    let ret = []
    for i in [0, 1, 2]
      if hunks[i] > 0
        call add(ret, symbols[i] . hunks[i])
      endif
    endfor
    return join(ret, ' ')
  endfunction

  function! LightLineFilename()
    return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
  endfunction

  " {{{ Modified jellybeans theme
  let s:base03    = [ '#151513', 233 ]
  let s:base02    = [ '#30302c', 236 ]
  let s:base01    = [ '#4e4e43', 237 ]
  let s:base00    = [ '#666656', 242 ]
  let s:base0     = [ '#808070', 244 ]
  let s:base1     = [ '#949484', 246 ]
  let s:base2     = [ '#a8a897', 248 ]
  let s:base3     = [ '#e8e8d3', 253 ]
  let s:yellow    = [ '#ffb964', 215 ]
  let s:red       = [ '#cf6a4c', 167 ]
  let s:magenta   = [ '#f0a0c0', 217 ]
  let s:blue      = [ '#7697D6', 4   ]
  let s:orange    = [ '#ffb964', 215 ]
  let s:green     = [ '#99ad6a', 107 ]
  let s:white     = [ '#FCFCFC', 15  ]

  let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}, 'terminal': {}}
  let s:p.normal.left     = [ [ s:white, s:blue ], [ s:base3, s:base02 ] ]
  let s:p.normal.right    = [ [ s:base02, s:base1 ], [ s:base3, s:base02 ] ]
  let s:p.inactive.right  = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
  let s:p.inactive.left   = [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
  let s:p.insert.left     = [ [ s:base02, s:orange ], [ s:base3, s:base01 ] ]
  let s:p.replace.left    = [ [ s:base02, s:red ], [ s:base3, s:base01 ] ]
  let s:p.visual.left     = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
  let s:p.terminal.left   = [ [ s:base02, s:green ], [ s:base3, s:base01 ] ]
  let s:p.normal.middle   = [ [ s:base0, s:base03 ] ]
  let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
  let s:p.tabline.left    = [ [ s:base3, s:base02 ] ]
  let s:p.tabline.tabsel  = [ [ s:white, s:blue ] ]
  let s:p.tabline.middle  = [ [ s:base01, s:base03 ] ]
  let s:p.tabline.right   = [ [ s:base03, s:base03 ], [ s:base03, s:base03 ] ]
  let s:p.normal.error    = [ [ s:red, s:base02 ] ]
  let s:p.normal.warning  = [ [ s:yellow, s:base01 ] ]


" Functionality
" ====================================================================
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File Search
" ====================================================================
Plug 'scrooloose/nerdtree'
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeHijackNetrw = 0
  let g:NERDTreeWinSize = 31
  let g:NERDTreeChDirMode = 2
  let g:NERDTreeAutoDeleteBuffer = 1
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeCascadeOpenSingleChildDir = 1

  map <C-l> :call NERDTreeToggleAndFind()<cr>
  map <C-o> :NERDTreeToggle<CR>

  function! NERDTreeToggleAndFind()
    if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
      execute ':NERDTreeClose'
    else
      execute ':NERDTreeFind'
    endif
  endfunction


Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
" {{{
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>
" }}}


Plug 'scrooloose/syntastic'
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_enable_signs          = 1
  let g:syntastic_enable_highlighting   = 1
  let g:syntastic_cpp_check_header      = 1
  let g:syntastic_enable_balloons       = 1
  let g:syntastic_echo_current_error    = 1
  let g:syntastic_check_on_wq           = 0
  let g:syntastic_error_symbol          = '✘'
  let g:syntastic_warning_symbol        = '!'
  let g:syntastic_style_error_symbol    = ':('
  let g:syntastic_style_warning_symbol  = ':('
  let g:syntastic_vim_checkers          = ['vint']
  let g:syntastic_elixir_checkers       = ['elixir']
  let g:syntastic_python_checkers       = ['pylint']
  let g:syntastic_javascript_checkers   = ['eslint']
  let g:syntastic_enable_elixir_checker = 0

call plug#end()
