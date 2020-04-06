import XCTest
@testable import cdd_rpc_swift

final class cdd_rpc_swiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(cdd_rpc_swift().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
