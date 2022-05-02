.PHONY: dev dev-test remote

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
	for d in */ ;\
	do echo "$$d" ;\
		stow "$$(basename "$$d")" -t "$$HOME" -vv ;\
		echo "------" ;\
	done ;\
	echo "stow complete";\

