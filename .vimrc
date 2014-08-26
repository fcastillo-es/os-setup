" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" my personal help
fu! Helpme()
  echo " "
  echo "  F1  - This help                           "
  echo "  F2  - Toggle paste / nopaste"
  echo "  F3  - Tag explorer                        <TAB> - next split window"
  echo "  F4  - Generate syntax colored HTML        gw    - swap current and next word"
  echo "  F5  - Use Perltidy                        <C-K> - split window upper"
  echo "  F6  - Reload .vimrc                       <C-J> - split window below"
  echo "  F7  - Aun no hace nada                    <C-H> - split window on the left"
  echo "  F8  - Aun no hace nada                    <C-L> - split window on the right"
  echo "  F9  - Previous buffer                     \"     - beautifies text"
  echo "  F10 - Next buffer                         <C-M> - maximize window"
  echo "  F11 - Light / Dark background             <C-N> - make all windows equal size"
  echo "  F12 - Number / Unumber lines              -     - line wrapping on / off"
  echo "  <   - decreases indentation by 4 spaces"
  echo "  >   - increases indentation by 4 spaces"
  echo " "
endf

map <silent> <F1> :exe Helpme()<CR>

set pastetoggle=<F2>

nnoremap <silent> <F3> :TagExplorer<CR>

" generate syntax colored HTML
map <silent> <F4> :runtime! syntax/2html.vim<CR>

" Tide up Perl code using Perltidy
map <silent> <F5> :%!/opt/local/bin/perltidy<CR>

" Reload .vimrc (overrides previous options, but does not remove them)
map <silent> <F6> :so $HOME/.vimrc<BAR>echo "Reloaded .vimrc"<CR>

"if (has("perl"))
"
"perl << PERL
"use Text::Beautify;
"sub beautify {
"  $_ = Text::Beautify::beautify($_);
"}
"PERL
"map <silent> " :perldo beautify($_)<CR>
"
"endif " has("perl")

" next / previous file
map <silent> <F10> :n<CR>
map <silent> <F9> :N<CR>

" dark / light background
map <silent> <F11> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" numbering / unumbering lines
map <silent> <F12> :set invnumber<BAR>echo (&number ? "Showing" : "Not showing") "numbers"<CR>

" line wrapping
map <silent> - :set invwrap<BAR>echo "value of wrap is" (&wrap ? "on" : "off")<CR>
" map <silent> - :set invwrap<BAR>set wrap?<CR>

" pressing up in a long line gets you to the above line "in the screen", etc.
noremap j gj
noremap k gk
noremap <Up> gk
noremap <Down> gj
inoremap <Up> <C-O>gk
inoremap <Down> <C-O>gj

" switching between windows in an easier way
" (still need to map <C-UP>, or something like that)
map <Tab> <C-W><C-W>
map <C-K> <C-W>k
map <C-J> <C-W>j
map <C-H> <C-W>h
map <C-L> <C-W>l

" maximize a window
map <C-M> <C-W><Bar><C-W>_<BAR>:echo "Window maximized"<CR>

" make all windows (almost) equally high and wide
map <C-N> <C-W>=<BAR>:echo "All windows equally sized"<CR>

" reverse status bar colors (useful when working with several windows)
:hi StatusLine ctermfg=white term=reverse cterm=reverse gui=reverse
:hi StatusLineNC ctermfg=blue term=reverse cterm=reverse gui=reverse

" make search results appear in the middle of the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" allow the . to execute once for each line of a visual selection
"vnoremap . :normal .<CR>
vnoremap . :<C-U>execute "'<,'>g/^/norm!" . virtcol("'<") . "\|."<CR><BAR>:noh<CR>

" type gw to swap the current word and the next one (english alphabet only)
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>

" some definitions
set backspace=2         " allow backspacing over everything in insert mode
set history=1000        " keep 1000 lines of command line history
set ruler               " show the cursor position all the time
set incsearch           " do incremental searching
set ic                  " ignore case in search patterns
set scs                 " smart search (override 'ic' when pattern has uppers)
set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file, use versions instead
set laststatus=2        " always display the status line
set nosol               " cursor is kept in the same column (if possible)
"set scr=5              " CTRL-U and CTRL-D scroll 5 lines at a time
set sw=2                " indentation now takes just 2 spaces at a time
set nrformats=          " only decimal numbers will be considered for increment

" Agregado por dk
set background=dark
set tabstop=4
set ai
set shiftwidth=4
"set smarttab
set expandtab
set showmatch
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [x=%04v,y=%04l][%p%%]\ [LEN=%L]
"set mouse=a         " Use the mouse to position, resize of splits, visual select and more :)

"solo para gvim/macvim
":colorscheme pablo
":set guifont=Monaco:h13


" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" some common typos
command! Qa qa
command! Q q
command! W w
command! Wq wq
" command! qq quit

" selecting all text
map <C-A> 1GvG$

" <C-B> removes highlight
map <silent> <C-B> :noh<CR>

" syntax highlighting on, when the terminal has colors
" also switch on highlighting the last used search pattern.
if &t_Co > 2||has("gui_running")
syntax on
set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$")|
\ exe "normal g`\""|
\ endif

" Enable file type detection
filetype on

autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab

endif " has("autocmd")

" test lines
ab shpl #!/usr/bin/perl
ab shrb #!/usr/bin/ruby
ab shsh #!/bin/sh
ab shpy #!/usr/bin/python

" automatically give executable permissions based on file extension
au BufWritePost *.\(?:sh\|py\|pl\|rb\) :silent !chmod a+x <afile>


" Misc script header function
    fun! <SID>ScriptHeader(lang)
        call setline(1, "#!/usr/bin/" . a:lang)
        call append(1, "")
    endfun

    " Call header function on listed file types
    " XXX: could use BufNewFile if BufEnter is too inclusive
    au BufEnter *.py if getline(1) == "" | call s:ScriptHeader("python") | endif
    au BufEnter *.pl if getline(1) == "" | call s:ScriptHeader("perl")   | endif
    au BufEnter *.rb if getline(1) == "" | call s:ScriptHeader("ruby")   | endif

    " Shell header
    fun! <SID>ShellHeader()
        call setline(1, "#!/bin/sh")
        call append(1, "")
    endfun

    au BufEnter *.sh if getline(1) == "" | call s:ShellHeader() | endif

" Twig sintax highlight
au BufRead,BufNewFile *.twig set filetype=htmljinja
au BufRead,BufNewFile *.html.twig set filetype=jinja
