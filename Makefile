pull upstream upgrade:
	git pull --ff-only
	git submodule update --init --recursive

.PHONY: pull upstream upgrade
