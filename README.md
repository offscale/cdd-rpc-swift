cdd-rpc-swift
=============
[![License](https://img.shields.io/badge/license-Apache--2.0%20OR%20MIT-blue.svg)](https://opensource.org/licenses/Apache-2.0)

cdd-rpc-swift is a Swift server that exposes a JSON-RPC interface to Swift AST manipulation, following Compiler Driven Development (CDD) methodology.

## Linux/MacOS

```bash
nix-shell --pure # optional, if you wish to use a pure nix environment
swift run
```

https://github.com/yanagiba/swift-ast - ast
https://github.com/apple/swift-nio - rpc sockets

## Dev environment

```bash
nix-shell
```

---

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or <https://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or <https://opensource.org/licenses/MIT>)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be
dual licensed as above, without any additional terms or conditions.
