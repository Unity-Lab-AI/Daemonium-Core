# Daemonium-Core Core Binary

The purpose of this folder is to package Typescript code in a way that can be run from any IDE or platform. We first bundle with `esbuild` and then package into binaries with `pkg`.

The `pkgJson/package.json` contains instructions for building with pkg, and needs to be in a separte folder because there is no CLI flag for the assets option (it must be in a package.json), and pkg doesn't recognize any name other than package.json, but if we use the same package.json with dependencies in it, pkg will automatically include these, significantly increasing the binary size.

The build process is otherwise defined entirely in `build.js`.

### List of native modules

- sqlite3/build/Release/node_sqlite3.node (\*)
- @lancedb/\*\*
- esbuild?
- @esbuild?
- onnxruntime-node?

### List of dynamically imported modules

- posthog-node
- @octokit/rest
- esbuild

### List of .wasm files

- tree-sitter.wasm
- tree-sitter-wasms/

(\*) = need to download for each platform manually

## Debugging

To debug the binary with IntelliJ, set `useTcp` to `true` in `CoreMessenger.kt`, and then in VS Code run the "Core Binary" debug script. Instead of starting a subprocess for the binary and communicating over stdin/stdout, the IntelliJ extension will connect over TCP to the server started from the VS Code window. You can place breakpoints anywhere in the `core` or `binary` folders.

## Building

```bash
npm run build
```

## Testing

```bash
npm run test
```
