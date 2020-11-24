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
                XCTAssertTrue(true)
            default:
                XCTFail()
        }
    }

    func testPrinterEmpty() throws {
        let result = printer.printing("")
        switch result {
            case .error(code: let code):
                XCTAssertTrue(code == 1)
            default:
                XCTFail()
        }
    }

    static var allTests = [
        ("testPrinter", testPrinter),
        ("testPrinterEmpty", testPrinterEmpty)
    ]
}