create-links:
	ln -s "$(pwd)/.config/nvim" ~/.config/nvim
	ln -s "$(pwd)/.config/starship.toml" ~/.config/starship.toml
	ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
	ln -s "$(pwd)/.config/neofetch" ~/.config/neofetch
	ln "$(pwd)/.zshrc" ~/.zshrc

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

nix-install:
	git add .
	sudo nixos-rebuild --flake ./nixos switch

nix-clean:
	sudo nix-collect-garbage -d
