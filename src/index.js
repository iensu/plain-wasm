const fs = require("fs");
const path = require("path");

function setString(memory, s) {
  const u8array = new Uint8Array(memory.buffer);
  const encoded = new TextEncoder().encode(s);
  u8array.set(encoded);

  return encoded.length;
}

function getString(memory) {
  const u8array = new Uint8Array(memory.buffer);
  return new TextDecoder().decode(u8array);
}

(async function run() {
  const bytes = fs.readFileSync(path.join(__dirname, "./upper.wasm"));
  const memory = new WebAssembly.Memory({ initial: 1, maximum: 10 });
  const { instance } = await WebAssembly.instantiate(bytes, {
    env: { memory }
  });

  const byteLength = setString(
    memory,
    "Cannot handle å,ä or ö, and I wonder how 日本語 works"
  );

  instance.exports.toUpper(0, byteLength);

  const result = getString(memory);

  console.log(result);
})();
