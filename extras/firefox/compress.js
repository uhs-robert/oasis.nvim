#!/usr/bin/env node
// extras/firefox/compress.js
// Compresses JSON theme data for Firefox Color using json-url LZMA codec

const JsonUrl = require('json-url');
const fs = require('fs');

const codec = JsonUrl('lzma');

// Read JSON from stdin
let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', async () => {
  try {
    const theme = JSON.parse(input);
    const compressed = await codec.compress(theme);
    process.stdout.write(compressed);
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
});
