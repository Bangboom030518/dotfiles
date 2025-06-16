nix-install:
	git add .
	sudo nixos-rebuild --flake ./nixos switch

home-clean:
	rm -f ~/.zshrc
	rm -f ~/.config/mimeapps.list
	rm -f ~/.config/mimeapps.list.backup

nix-clean:
	sudo nix-collect-garbage -d
