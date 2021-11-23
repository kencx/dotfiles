dev:
	cd ./dots || exit ;\
	for d in */ ;\
	do echo "$$d" ;\
		stow "$$(basename "$$d")" -t "$$HOME" -vv ;\
		echo "------" ;\
	done

dev-test:
	cd ./dots || exit ;\
	for d in */ ;\
	do echo "$$d" ;\
		stow -n "$$(basename "$$d")" -t "$$HOME" -vv ;\
		echo "------" ;\
	done

