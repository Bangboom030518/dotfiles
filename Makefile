create-links:
	ln -s "$(pwd)/.config/starship.toml" ~/.config/starship.toml
	ln "$(pwd)/.zshrc" ~/.zshrc

nix-install:
	git add .
	sudo nixos-rebuild --flake ./nixos switch

nix-clean:
	sudo nix-collect-garbage -d
