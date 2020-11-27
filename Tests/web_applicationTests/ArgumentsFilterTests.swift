@testable import web_application

import XCTest

final class ArgumentsFilterTests: XCTestCase {
    private var argumentsFilter: ArgumentsFilter!
    
    override func setUp() {
        argumentsFilter = ArgumentsFilter()
    }
    
    func testFilterWithKeyAndLanguage() throws {
        let result = argumentsFilter.filter("key", "language")
        switch result {
        case .keyAndLanguage(valueOfKey: let key, valueOfLanguage: let language):
            XCTAssertEqual(key, "key")
            XCTAssertEqual(language, "language")
        default:
            XCTFail("Wrong arguments")
        }
    }

    func testFilterWithKey() throws {
        let result = argumentsFilter.filter("key", nil)
        switch result {
        case .key(value: let key):
            XCTAssertEqual("key", key) 
        default:
            XCTFail("Wrong arguments")
        }
    }    

    func testFilterWithLanguage() throws {
        let result = argumentsFilter.filter(nil, "language")
        switch result {
        case .language(value: let language):
            XCTAssertEqual(language, "language")
        default:
            XCTFail("Wrong arguments")
        }
    }

    func testFilter() throws {
        let result = argumentsFilter.filter(nil, nil)
        switch result {
        case .nothing:
            XCTAssertTrue(true)
        default:
            XCTFail("Wrong arguments")
        }
    }

    static var allTests = [
        ("testFilterWithKeyAndLanguage", testFilterWithKeyAndLanguage),
        ("testFilterWithKey", testFilterWithKey),
        ("testFilterWithLanguage", testFilterWithLanguage),
        ("testFilter", testFilter)
    ]
}
