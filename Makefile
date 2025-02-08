all: build

build:
	elm make --optimize src/Main.elm --output=klira.js

clean:
	rm -f klira.js
	rm -rf elm-stuff
