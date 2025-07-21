import Foundation
import SwiftUI
#if os(iOS)
import DeviceKit
#elseif os(macOS)
import DeviceModel
#endif

/// Returns a string describing the current device and app.
/// - Returns: formatted string containing app name, version, device info, OS version and screen resolution.
@MainActor
public func getDeviceInfo() -> String {
    // App information
    let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown"
    let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"

    #if os(iOS)
    if ProcessInfo.processInfo.isiOSAppOnMac {
        let iosVersion = UIDevice.current.systemVersion
        let screenResolution = "\(Int(UIScreen.main.bounds.width))x\(Int(UIScreen.main.bounds.height))"

        let deviceInfo: String = if let modelID = sysctlString(for: "hw.model") {
            "/\(modelID)"
        } else {
            ""
        }
        let cpuInfo: String = if let cpuName = getCPUName() {
            "/\(cpuName)"
        } else {
            ""
        }
        return "\(appName) \(appVersion)\(deviceInfo)\(cpuInfo)/iOS(on Mac) \(iosVersion)/\(screenResolution)"
    } else {
        let deviceName = Device.current
        let iosVersion = UIDevice.current.systemVersion
        let screenResolution = "\(Int(UIScreen.main.bounds.width))x\(Int(UIScreen.main.bounds.height))"

        return "\(appName) \(appVersion)/\(deviceName)/iOS \(iosVersion)/\(screenResolution)"
    }
    #elseif os(macOS)
    let systemVersion = ProcessInfo.processInfo.operatingSystemVersion
    let osVersionString = "\(systemVersion.majorVersion).\(systemVersion.minorVersion).\(systemVersion.patchVersion)"

    if let mainScreen = NSScreen.main {
        let width = Int(mainScreen.frame.width)
        let height = Int(mainScreen.frame.height)
        let screenResolution = "\(width)x\(height)"

        let deviceInfo: String = if let modelID = DeviceModel.current() {
            "/\(modelID)"
        } else {
            ""
        }
        let cpuInfo: String = if let cpuName = getCPUName() {
            "/\(cpuName)"
        } else {
            ""
        }
        return "\(appName) \(appVersion)\(deviceInfo)\(cpuInfo)/macOS \(osVersionString)/\(screenResolution)"
    } else {
        return "\(appName) \(appVersion)/Mac/macos \(osVersionString)/UnknownScreen"
    }
    #else
    return "\(appName) \(appVersion)"
    #endif
}

#if os(iOS)
extension UIDevice {
    public var modelName: String {
        "\(Device.current)"
    }
}
#endif

private func sysctlString(for name: String) -> String? {
    var size = 0
    guard sysctlbyname(name, nil, &size, nil, 0) == 0, size > 0 else { return nil }
    var buffer = [UInt8](repeating: 0, count: size)
    guard sysctlbyname(name, &buffer, &size, nil, 0) == 0 else { return nil }
    if buffer.last == 0 { buffer.removeLast() }
    return String(decoding: buffer, as: UTF8.self)
}

func getCPUName() -> String? {
    sysctlString(for: "machdep.cpu.brand_string")
}

