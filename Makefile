nix-install:
	git add .
	sudo nixos-rebuild --flake ./nixos switch

nix-clean:
	sudo nix-collect-garbage -d
