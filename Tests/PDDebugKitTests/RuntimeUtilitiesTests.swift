import Testing
@testable import PDDebugKit
import Foundation

private class SampleClass: NSObject {
    @objc func exampleMethod() {}
}

@Test func dumpSelectorsReturnsMethods() async throws {
    let methods = dumpSelectors(of: SampleClass.self)
    #expect(methods.contains("exampleMethod"))
}
