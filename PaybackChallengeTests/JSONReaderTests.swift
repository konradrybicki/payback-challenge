import XCTest

@testable import PaybackChallenge

final class JSONReaderTests: XCTestCase {
    func testReadFileContent_withIncorrectFileName() {
        let expectation = XCTestExpectation(description: "Incorrect file name.")
        
        let reader = JSONReader(fileName: "foo")
        reader.readFileContent { (result: Result<TransactionList, JSONReaderError>) in
            switch result {
            case .success(_):
                XCTFail("Operation succeeded.")
            case .failure(let error):
                switch error {
                case .incorrectFileName:
                    expectation.fulfill()
                case .noData:
                    XCTFail("No data.")
                case .decodingError(let error):
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testReadFileContent_forDecodingError() {
        let expectation = XCTestExpectation(description: "Decoding error.")

        struct MosEisley: JSONContent {
            let thatsNotTheFieldYoureLookingFor: String
        }

        let reader = JSONReader(fileName: Files.transactionsMock)
        reader.readFileContent { (result: Result<MosEisley, JSONReaderError>) in
            switch result {
            case .success(_):
                XCTFail("Operation succeeded.")
            case .failure(let error):
                switch error {
                case .incorrectFileName:
                    XCTFail("Incorrect file name.")
                case .noData:
                    XCTFail("No data.")
                case .decodingError(_):
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testReadFileContent_forSuccess() {
        let expectation = XCTestExpectation(description: "Read file content successfully.")
        
        let reader = JSONReader(fileName: Files.transactionsMock)
        reader.readFileContent { (result: Result<TransactionList, JSONReaderError>) in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(let error):
                switch error {
                case .incorrectFileName:
                    XCTFail("Incorrect file name.")
                case .noData:
                    XCTFail("No data.")
                case .decodingError(let error):
                    XCTFail("Decoding error: \(error)")
                }
            }
        }
        wait(for: [expectation], timeout: 1)
    }
}
