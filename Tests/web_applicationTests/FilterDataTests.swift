@testable import web_application

import XCTest

final class FilterDataTests: XCTestCase {
    private var filterData: FilterData!
    override func setUp() {
        let dataBase = DataBaseMock()
        filterData = FilterData(dataBase: dataBase)
    }

    func testFilterByKeyAndLanguage() throws {
        let arguments = ArgumentsType.keyAndLanguage(valueOfKey: "day", valueOfLanguage: "en")
        let result = filterData.filter(arguments)
        XCTAssertTrue(result == "Day")
    }

    func testFilterByKeyAndLanguageEmpty() throws {
        let arguments = ArgumentsType.keyAndLanguage(valueOfKey: "pig", valueOfLanguage: "en")
        let result = filterData.filter(arguments)
        XCTAssertTrue(result == "")
    }

    func testFilterByKey() throws {
        let arguments = ArgumentsType.key(value: "cat")
        let result = filterData.filter(arguments)
        let expectedResult = "cat:\n\ten: Cat\n"
        XCTAssertTrue(result == expectedResult)
    }

    func testFilterByKeyEmpty() throws {
        let arguments = ArgumentsType.key(value: "pig")
        let result = filterData.filter(arguments)
        let expectedResult = ""
        XCTAssertTrue(result == expectedResult)
    }

    func testFilterByLanguage() throws {
        let arguments = ArgumentsType.language(value: "ru")
        let result = filterData.filter(arguments)
        XCTAssertTrue(result.contains("day = День\n"))
        XCTAssertTrue(result.contains("night = Ночь\n"))
    }

    func testFilterByLanguageEmpty() throws {
        let arguments = ArgumentsType.language(value: "it")
        let result = filterData.filter(arguments)
        let expectedResult = ""
        XCTAssertTrue(result == expectedResult)
    }

    func testFilter() throws {
        let arguments = ArgumentsType.nothing
        let result = filterData.filter(arguments)
        XCTAssertTrue(result.contains("day:\n\ten: Day\n\tru: День\n") || result.contains("day:\n\tru: День\n\ten: Day\n"))
        XCTAssertTrue(result.contains("night:\n\ten: Night\n\tru: Ночь\n") || result.contains("night:\n\tru: Ночь\n\ten: Night\n"))
        XCTAssertTrue(result.contains("cat:\n\ten: Cat\n"))
    }

    

    static var allTests = [
        ("testFilterByKeyAndLanguage", testFilterByKeyAndLanguage),
        ("testFilterByKeyAndLanguageEmpty", testFilterByKeyAndLanguageEmpty),
        ("testFilterByKey", testFilterByKey),
        ("testFilterByKeyEmpty", testFilterByKeyEmpty),
        ("testFilterByLanguage", testFilterByLanguage),
        ("testFilterByLanguageEmpty", testFilterByLanguageEmpty),
        ("testFilter", testFilter)
    ]   
}