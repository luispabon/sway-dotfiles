build:
	docker build -t kanshi_build .

copy-bin:
	docker create --name=deleteme kanshi_build
	docker cp "deleteme:/usr/local/cargo/bin/kanshi" ~/bin/
	docker rm deleteme
