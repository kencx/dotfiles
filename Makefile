.PHONY: stow dev dev-test remote

stow:
	cd ./dots || exit ;\
	stow "$(c)" -t "$$HOME" -vv

dev:
	cd ./dots || exit ;\
	for d in */ ;\
	do echo "$$d" ;\
		stow "$$(basename "$$d")" -t "$$HOME" -vv ;\
		echo "------" ;\
	done ;\
	echo "stow complete";\
	cp etc/.Xresources "$$HOME/.Xresources" ;\
	cp etc/desktop/* "$$HOME/.local/share/applications/"

dev-test:
	cd ./dots || exit ;\
	for d in */ ;\
	do echo "$$d" ;\
		stow -n "$$(basename "$$d")" -t "$$HOME" -vv ;\
		echo "------" ;\
	done ;\
	echo "stow test complete"

remote:
	cd ./remote || exit ;\
	stow "$$(basename "./vim")" -t "$$HOME" -vv ;\
	echo "stow complete";\
	git clone https://github.com/morhetz/gruvbox.git "$$HOME/.vim/pack/default/start/gruvbox" ;\
	echo "Installed gruvbox theme"

