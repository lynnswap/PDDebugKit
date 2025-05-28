# PDDebugKit

PDDebugKit is a Swift package that provides helper APIs for debugging.

Currently it includes an API to return device and app information and utilities for working with the Objective‑C runtime.

## Usage

Add PDDebugKit as a dependency in your Swift Package manifest and import it in your code.

### Getting device information

Call `getDeviceInfo()` from the main actor to retrieve a formatted description of the running app and device:

```swift
let info = getDeviceInfo()
print(info)
```

### Listing selectors

```swift
let methodNames = dumpSelectors(of: MyClass.self, includingInherited: true)
```

## License

This project is released under the MIT License. See [LICENSE](LICENSE) for details.
