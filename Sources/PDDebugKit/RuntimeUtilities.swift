import Foundation
import ObjectiveC.runtime

/// Returns an array of selector names for the given class.
/// - Parameters:
///   - cls: The class to inspect.
///   - includingInherited: If `true`, include selectors from superclasses.
/// - Returns: A list of selector names.
public func dumpSelectors(of cls: AnyClass, includingInherited: Bool = false) -> [String] {
    var selectors: [String] = []
    var target: AnyClass? = cls
    repeat {
        var count: UInt32 = 0
        if let list = class_copyMethodList(target, &count) {
            defer { free(list) }
            for i in 0..<Int(count) {
                let sel = method_getName(list[i])
                selectors.append(NSStringFromSelector(sel))
            }
        }
        target = includingInherited ? class_getSuperclass(target) : nil
    } while target != nil
    return selectors
}
