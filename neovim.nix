{pkgs , ... }:
{
  # Neovim
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        let g:highlightedyank_highlight_duration = 200

        set nocompatible
        syntax on
        filetype on
        colorscheme gruvbox


        let tabsize = 2
        let &shiftwidth=tabsize
        let &tabstop=tabsize
        let &softtabstop=tabsize
        set smarttab
        set expandtab
        set confirm
        set inccommand=nosplit
        set showcmd
        set nohls
        set wildmenu
        set number
        set noerrorbells
        set nu
        set nowrap
        set smartcase
        set noswapfile
        set incsearch
        set colorcolumn=80
        set ignorecase

        let g:netrw_banner = 0
        let g:netrw_liststyle = 3

        let mapleader = " "

        function FQuit()
          let choice = confirm("Are you sure you want to Quit? Unsaved progress could be lost.", "&Yes\n&No", 2)
          if choice == 1
            :q!
          endif
        endfunction

        function GitPullSafe()
          let choice = confirm("Are you sure you want to Pull the repo? Unsaved progress could be lost.", "&Yes\n&No", 2)
          if choice == 1
            :Git pull
          endif
        endfunction

        "Exit Terminal Mode With Escape"
        tnoremap <esc> <C-\><C-n> 

        "Main Helper Hunctions"
        noremap <leader>w  :w <CR>
        noremap <leader>q :q <CR> 
        noremap <leader>Q  :call FQuit() <CR> 
        noremap <leader>n  :tabedit <CR> 
        noremap <leader>r  :read!  
        noremap <leader>d  :cd %:h<CR>  

        "Edit Files"
        noremap <leader>ec :tabedit $MYVIMRC <CR> 
        noremap <leader>sc :source $MYVIMRC <CR> 
        noremap <leader><tab> :e . <CR> 
        noremap <leader>en :tabedit . <CR> 

        "Window Movement"
        noremap <leader>l <C-w>l 
        noremap <leader>k <C-w>k 
        noremap <leader>j <C-w>j 
        noremap <leader>h <C-w>h 
        noremap <leader>o <C-w>o 

        "Splits"
        noremap <leader>sv :vsplit <CR>
        noremap <leader>sh :split <CR>

        "Tab Movement"
        noremap <leader>( gT
        noremap <leader>) gt
        noremap <leader>c :tabo <CR>

        "Terminal"
        noremap <leader>t :!
        noremap <leader>T :term<CR>

        "Table"
        vmap <leader>t :!column -t <CR> gv

        "Indent"
        vmap <leader>l >gv
        vmap <leader>h <gv

        "Normal Command"
        vmap <leader>n :norm 

        "Fuzzy Finder"
        nnoremap <leader>f :FZF<CR>
        nnoremap <leader>F :FZF ~<CR>

        "Git shortcuts"
        noremap <leader>gs :G <CR>
        noremap <leader>gd :Git diff <CR>
        noremap <leader>gb :Git blame <CR>
        noremap <leader>ga :Git add 
        noremap <leader>gA :Git add %<CR>
        noremap <leader>gc :Git commit<CR>
        noremap <leader>gP :call GitPullSafe() <CR>
        '';
        packages.nix.start = with pkgs.vimPlugins; [
          vim-nix
          fugitive
          vim-visual-multi
          fzf-vim
          nvim-cursorline
          vim-highlightedyank
          gruvbox
        ];
      };
  };
}
