install:
	git add .
	sudo nixos-rebuild --flake ./nixos switch
