# Plain WebAssembly

Playing around with plain WebAssembly.

## Requirements

* NodeJS
* WebAssembly Build Tools (WABT)

## Run the code in node.js

1. `wat2wasm src/upper.wat -o src/upper.wasm`
2. node src/index.js

## Run the code in a browser

1. Start a server in the current directory, for instance: `python3 -m http.server`
2. Navigate to `http://localhost:<PORT>/src/index.html`
