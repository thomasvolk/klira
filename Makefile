all: build

build:
	mkdir -p out
	elm make --optimize src/Main.elm --output=out/klira.js
	cp src/index.html out/
	cp -r src/resources out/

clean:
	rm -rf out
	rm -rf elm-stuff
