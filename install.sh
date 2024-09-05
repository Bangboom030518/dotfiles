ln -s "$(pwd)/.config/nvim" ~/.config/nvim
ln -s "$(pwd)/.config/starship.toml" ~/.config/starship.toml
ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
ln -s "$(pwd)/.config/neofetch" ~/.config/neofetch
ln "$(pwd)/.zshrc" ~/.zshrc
sudo ln "$(pwd)/configuration.nix" /etc/nixos/configuration.nix
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
