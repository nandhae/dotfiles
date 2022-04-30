Install nix
curl -L https://nixos.org/nix/install | sh

# source nix
. ~/.nix-profile/etc/profile.d/nix.sh

# install packages
nix-env -iA \
		nixpkgs.zsh \
		nixpkgs.antibody \
		nixpkgs.git \
		nixpkgs.neovim \
		nixpkgs.tmux \
		nixpkgs.stow \
		nixpkgs.yarn \
		nixpkgs.fzf \
		nixpkgs.ripgrep \
		nixpkgs.bat \
		nixpkgs.gnumake \
		nixpkgs.gcc \
		nixpkgs.direnv

# stow dotfiles
stow git
stow nvim
stow tmux
stow zsh

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# bundle zsh plugins 
 antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh

# install vim-plug and neovim plugins
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim --headless +PlugInstall +qall

# Use kitty terminal on MacOS
[ `uname -s` = 'Darwin' ] && stow kitty
