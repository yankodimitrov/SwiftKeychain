import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GenericPasswordTypeExtensionsTests.allTests),
        testCase(KeychainItemTypeExtensionsTests.allTests),
        testCase(KeychainTests.allTests),
    ]
}
#endif
