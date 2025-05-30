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

## Apps Using

<p float="left">
    <a href="https://apps.apple.com/jp/app/tweetpd/id1671411031"><img src="https://i.imgur.com/AC6eGdx.png" height="65"></a>
</p>

## License

This project is released under the MIT License. See [LICENSE](LICENSE) for details.
