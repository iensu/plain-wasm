const fs = require("fs");
const path = require("path");

/**
 * Writes a string to the provided memory buffer and returns the number of written bytes.
 */
function setString(memory, s) {
  const u8array = new Uint8Array(memory.buffer); // View the memory buffer as an array of bytes
  const encoded = new TextEncoder().encode(s);
  u8array.set(encoded); // Write encoded string to the memory buffer as bytes

  return encoded.length;
}

/**
 * Returns the content of the memory buffer as a string
 */
function getString(memory, length) {
  const u8array = new Uint8Array(memory.buffer); // View memory buffer as an array of bytes
  const decoded = new TextDecoder().decode(
    u8array.slice(0, length || u8array.length)
  );

  return decoded;
}

/**
 * Loads a WebAssembly module and returns it.
 */
async function loadWasm(filePath, moduleConfig) {
  const bytes = fs.readFileSync(path.join(__dirname, filePath));

  return WebAssembly.instantiate(bytes, moduleConfig);
}

/* SCRIPT START */

(async function run() {
  const memory = new WebAssembly.Memory({ initial: 1, maximum: 10 });

  const { instance } = await loadWasm("./upper.wasm", {
    env: { memory }
  });

  const byteLength = setString(
    memory,
    "Cannot handle å,ä or ö, and I wonder how 日本語 works"
  );

  instance.exports.toUpper(0, byteLength);

  const result = getString(memory, byteLength);

  console.log(result);
})();
