@testable import web_application

import XCTest

final class PrinterTests: XCTestCase {
    private var printer: Printer!
    
    override func setUp() {
        printer = Printer()
    }

    func testPrinter() throws {
        let result = printer.printing("text")
        switch result {
            case .success:
                break
            default:
                XCTFail("Didn't text a message")
        }
    }

    func testPrinterEmpty() throws {
        let result = printer.printing("")
        switch result {
            case .error(code: let code, _):
                XCTAssertTrue(code == 1)
            default:
                XCTFail("Texted something")
        }
    }

    static var allTests = [
        ("testPrinter", testPrinter),
        ("testPrinterEmpty", testPrinterEmpty)
    ]
}