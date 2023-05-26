import XCTest

@testable import PaybackChallenge

final class DateTests: XCTestCase {
    func testDateFromString_forIncorrectDate() {
        let dateString = "foo"
        let date = Date.fromString(dateString)
        XCTAssertNil(date)
    }

    func testDateFromString_forCorrectDate() {
        let dateString = "2022-07-24T10:59:05+0200"
        let date = Date.fromString(dateString)
        XCTAssertNotNil(date)
    }
}
