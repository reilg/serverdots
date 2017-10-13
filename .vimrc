silent! if plug#begin()
if !has('nvim')
  Plug 'ConradIrwin/vim-bracketed-paste'
endif
Plug 'nanotech/jellybeans.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-easy-align'
call plug#end()
endif

if has('termguicolors')
  if !empty($TMUX)
    " :h xterm-true-color
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif

set background=dark
" Use transparent background (i.e. the same colour as the terminal).
let g:jellybeans_overrides = {'background': {'ctermbg': 'none', 'guibg': 'none'}}
silent! colorscheme jellybeans

" Smart way to move between windows
no <C-j> <C-W>j
no <C-k> <C-W>k
no <C-h> <C-W>h
no <C-l> <C-W>l

" Replace annoying highlights
hi LineNr cterm=none
hi LineNr ctermfg=darkgrey
hi NonText ctermfg=darkgrey

" Highlight cursor for easy viewing
set cursorline

" Add some buffer for scrolling
set scrolloff=8

" Disable wrapping
set nowrap

" Map ctrlp to \\
let g:ctrlp_map = '<leader>\'

" Set to read all files
let g:ctrlp_max_files=0 

" Persist cache on all sessions (use f5 to refresh list)
let g:ctrlp_clear_cache_on_exit = 0

" Map leader+o to CtrlPBuffer search
no <leader>o :CtrlPBuffer<CR>

" Map leader+o to CtrlPMRU search
no <leader>i :CtrlPMRU<CR>

" Map leader+u to CtrlPMixed search
no <leader>u :CtrlPMixed<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Recent versions of the default Python syntax file is better than what is
" currently provided by vim-polyglot.
" See https://github.com/sheerun/vim-polyglot/issues/209.
let g:polyglot_disabled = ['python']

" Highlight numbers, builtin functions, standard exceptions, doctest, trailing
" whitespace and mix of spaces and tabs.
let g:python_highlight_all = 1

" vim-vinegar will try to hide the banner.
let g:netrw_banner = 1

" Tree style listing in netrw.
let g:netrw_liststyle = 3

" Hide patterns specified in .gitignore. Press "a" to cycle through the hiding modes.
" :h netrw-hiding
if has('patch-7.4.156')
  let g:netrw_list_hide = netrw_gitignore#Hide()
endif

" Press CTRL-^ to return to the last edited file, instead of the netrw browsing buffer.
let g:netrw_altfile = 1

" menuone   Use the popup menu also when there is only one match.
"           Useful when there is additional information about the
"           match, e.g., what file it comes from.
"
" preview   Show extra information about the currently selected
"           completion in the preview window.
" noselect  Do not select a match in the menu, force the user to
"           select one from the menu.
" does not work versions < 7.4
" set completeopt=menuone,preview,noselect

" Don't break a line after a one-letter word. It's broken before it
" instead (if possible).
set formatoptions+=1

if has('patch-7.3.541')
  " Where it makes sense, remove a comment leader when joining lines.
  set formatoptions+=j
endif

" Include column number (%c) in the grep format list.
set grepformat^=%f:%l:%c:%m
let &grepprg = 'grep --binary-file=without-match --recursive --line-number $* *'

" Highlight all search matches.
set hlsearch

" Always do case-insensitive search, unless the pattern contains upper case characters.
set ignorecase smartcase

" Show invisible characters, e.g. tabs and trailing whitespace.
set list listchars=tab:\›\ ,trail:-,extends:>,precedes:<,eol:¬

" Show line numbers.
set number

" Show the line number relative to the line with the cursor in front of each line.
" Disabled by default since it's known to considerably slow down scrolling.
if exists('+relativenumber')
  " set relativenumber
endif

" Highlight current line.
" Disabled by default since it's known to considerably slow down scrolling.
if exists('+cursorline')
  " set cursorline
endif

" Use 4-space indentation by default.
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

if exists('+breakindent')
  " Every wrapped line will continue visually indented (same amount of
  " space as the beginning of that line), thus preserving horizontal blocks
  " of text.
  set breakindent
  " Display the 'showbreak' value before applying the additional indent.
  set breakindentopt=sbr
  let &showbreak = "\u21AA "
endif

" When more than one match, list all matches.
set wildmode=list:longest,list:full

" Case-insensitive wild menu.
if exists('+wildignorecase')
  set wildignorecase
end

set directory=~/.vim/swaps
if !isdirectory(&directory)
  call mkdir(&directory)
endif

set backupdir=~/.vim/backups
if !isdirectory(&backupdir)
  call mkdir(&backupdir)
endif

if has('persistent_undo')
  set undodir=~/.vim/undos
  set undofile
  if !isdirectory(&undodir)
    call mkdir(&undodir)
  endif
endif

" Do a grep search and open the result in a quickfix window.
" :Grep foobar
command! -bar -nargs=+ -complete=file Grep silent! grep! <args>

" Automatically open the quickfix window when populated.
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
  " autocmd VimEnter        *     cwindow
augroup END

" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \  if &filetype !~ 'svn\|commit\c' |
        \    if line("'\"") >= 1 && line("'\"") <= line("$") |
        \      exe "normal! g`\"" |
        \    endif |
        \  endif
augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" Neovim specific settings.
if has('nvim')
  " <Esc> to exit terminal mode.
  tnoremap <Esc> <C-\><C-n>
  " Automatically enter terminal mode.
  augroup term
    autocmd!
    autocmd BufEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  augroup END
endif

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" FUNCTION FOR VISUAL SECTION SEARCHING
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vno <silent> * :call VisualSelection('f', '')<CR>
vno <silent> # :call VisualSelection('b', '')<CR>

" Zoom / Restore window.
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<CR>

" Local settings.
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" vi: ts=2 sts=2 sw=2 et:
