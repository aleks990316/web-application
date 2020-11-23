@testable import web_application

import XCTest

final class PrinterTests: XCTestCase {
    private var printer: Printer!
    
    override func setUp() {
        printer = Printer()
    }

    func testPrinter() throws {
        let result = printer.printing("text")
        XCTAssertTrue(result ==  0)
    }

    func testPrinterEmpty() throws {
        let result = printer.printing("")
        XCTAssertTrue(result == 1)
    }

    static var allTests = [
        ("testPrinter", testPrinter),
        ("testPrinterEmpty", testPrinterEmpty)
    ]
}