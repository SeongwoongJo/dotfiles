#! /bin/bash

#==================================================#
DOT_DIR=$PWD
echo; echo '** DOT_DIR: ' $DOT_DIR

#==================================================#
echo; echo '** download prerequisite libraries.'
bash $DOT_DIR/src/install-prerequisite.sh


#==================================================#
echo; echo '** link custom configurations.'
source "$PWD/aliases/misc"
ln -sf $DOT_DIR/assets/Xmodmap $HOME/.Xmodmap 
mkdir -p $HOME/.config/nvim && ln -sf $DOT_DIR/init.lua $HOME/.config/nvim/init.lua && ln -sf $DOT_DIR/lua $HOME/.config/nvim/lua
ln -sf $DOT_DIR/tmux.conf $HOME/.tmux.conf
ln -sf $DOT_DIR/aliases $HOME/.aliases
ln -sf $DOT_DIR/gitconfig $HOME/.gitconfig
ln -sf $DOT_DIR/zshrc $HOME/.zshrc


# #==================================================#
echo; echo '** download oh-my-zsh.'
bash $DOT_DIR/src/install-omz.sh; 
ln -sf $DOT_DIR/assets/mrtazz_custom.zsh-theme $HOME/.oh-my-zsh/themes/


#==================================================#
# download useful plugins
echo; echo '** download zsh plugin manager, zplug.'
git clone https://github.com/zplug/zplug $HOME/.zplug


#==================================================#
# download neovim plugins from lazy.nvim
nvim --headless "+Lazy! install" +qa
# nvim --headless "+Lazy! update" +qa
pip install pylatexenc
cargo install --locked tree-sitter-cli # to install latex parser
nvim --headless "+TSUpdateSync python lua c cpp markdown markdown_inline latex html bash diff luadoc query vim vimdoc" -c "q"

#==================================================#
# set zsh to the default shell
echo; echo '** set ZSH as default shell.'
locale-gen en_US.UTF-8
echo "exec zsh" >> $HOME/.bash_profile
exec zsh


