.PHONY: help stow unstow install uninstall remote update

help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

## stow: stow directory
stow:
	./setup stow "$(c)"

## unstow: unstow directory
unstow:
	./setup unstow "$(c)"

## install: Run full installation
install:
	./setup install

## uninstall: Run full uninstallation
uninstall:
	./setup uninstall

## remote: Install remote dotfiles
remote:
	cd ./remote || exit ;\
	stow "$$(basename "./vim")" -t "$$HOME" -vv ;\
	echo "stow complete";\
	git clone https://github.com/morhetz/gruvbox.git "$$HOME/.vim/pack/default/start/gruvbox" ;\
	echo "Installed gruvbox theme"

## update: Update submodules
update:
	git submodule foreach git pull origin master
