@testable import web_application

import XCTest

final class FilterDataTests: XCTestCase {
    private var filterData: FilterData!
    private var dataBase: DataBaseMock!
    private var sampleData = ["day": ["en": "Day", "ru": "День"], "night": ["en": "Night", "ru": "Ночь"], "cat": ["en": "Cat"]]
    override func setUp() {
        dataBase = DataBaseMock()
        filterData = FilterData(dataBase: dataBase)
    }

    func testFilterByKeyAndLanguage() throws {
        let arguments = ArgumentsType.keyAndLanguage(valueOfKey: "day", valueOfLanguage: "en")
        let result = filterData.filter(arguments)
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(result == "Day")
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testFilterByKeyAndLanguageEmpty() throws {
        let arguments = ArgumentsType.keyAndLanguage(valueOfKey: "pig", valueOfLanguage: "en")
        let result = filterData.filter(arguments)
        XCTAssertTrue(result == "")
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testFilterByKey() throws {
        let arguments = ArgumentsType.key(value: "cat")
        let result = filterData.filter(arguments)
        let expectedResult = "cat:\n\ten: Cat\n"
        XCTAssertTrue(result == expectedResult)
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testFilterByKeyEmpty() throws {
        let arguments = ArgumentsType.key(value: "pig")
        let result = filterData.filter(arguments)
        let expectedResult = ""
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(result == expectedResult)
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testFilterByLanguage() throws {
        let arguments = ArgumentsType.language(value: "ru")
        let result = filterData.filter(arguments)
        XCTAssertTrue(result.contains("day = День\n"))
        XCTAssertTrue(result.contains("night = Ночь\n"))
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testFilterByLanguageEmpty() throws {
        let arguments = ArgumentsType.language(value: "it")
        let result = filterData.filter(arguments)
        let expectedResult = ""
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(result == expectedResult)
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testFilter() throws {
        let arguments = ArgumentsType.nothing
        let result = filterData.filter(arguments)
        XCTAssertTrue(result.contains("day:\n\ten: Day\n\tru: День\n") || result.contains("day:\n\tru: День\n\ten: Day\n"))
        XCTAssertTrue(result.contains("night:\n\ten: Night\n\tru: Ночь\n") || result.contains("night:\n\tru: Ночь\n\ten: Night\n"))
        XCTAssertTrue(result.contains("cat:\n\ten: Cat\n"))
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

    func testEmpty() throws {
        let arguments = ArgumentsType.nothing
        sampleData = [ : ]
        dataBase = DataBaseMock(data: sampleData)
        filterData = FilterData(dataBase: dataBase)
        let result = filterData.filter(arguments)
        XCTAssertTrue("" == result)
        XCTAssertTrue(dataBase.numberOfCallsGetData == 1)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
        XCTAssertTrue(sampleData == dataBase.sampleData!)
        XCTAssertTrue(dataBase.numberOfCallsDeleteData == 0)
    }

        

    static var allTests = [
        ("testFilterByKeyAndLanguage", testFilterByKeyAndLanguage),
        ("testFilterByKeyAndLanguageEmpty", testFilterByKeyAndLanguageEmpty),
        ("testFilterByKey", testFilterByKey),
        ("testFilterByKeyEmpty", testFilterByKeyEmpty),
        ("testFilterByLanguage", testFilterByLanguage),
        ("testFilterByLanguageEmpty", testFilterByLanguageEmpty),
        ("testFilter", testFilter),
        ("testEmpty", testEmpty)
    ]   
}