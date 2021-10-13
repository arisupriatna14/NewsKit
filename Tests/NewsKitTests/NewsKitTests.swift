import XCTest
@testable import NewsKit

final class NewsKitTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(NewsKit().text, "Hello, World!")
    }
}
