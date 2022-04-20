import XCTest
@testable import Recursion

final class RecursionTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        // XCTAssertEqual(Recursion().text, "Hello, World!")
        
        let recur = Recursion.generateGrowingClosure()

        recur { print("1") }
        recur { print("2") }
        recur { print("3") }
        recur { print("4") }

        XCTAssertNotNil(recur)
    }
}
