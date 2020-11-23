@testable import web_application

import XCTest

final class DataBaseTests: XCTestCase {
    private var dataBase: DataBase!
    private var sampleData = ["day": ["en": "Day", "ru": "День"], "night": ["en": "Night", "ru": "Ночь"], "cat": ["en": "Cat"]]
    override func setUp() {
        dataBase = DataBase(data: sampleData)
    }

    func testGetData() throws {
        guard let data = dataBase.getData() else {
            XCTFail("Database has not returned data")
            return
        }
        XCTAssertTrue(data == sampleData)
    }

    func testUpdateDataForNewKey() throws {
        dataBase.updateData("Собака", "dog", "ru")
        sampleData.updateValue(["ru" : "Собака"], forKey: "dog")
        XCTAssertTrue(dataBase.getData()! == sampleData)
    }

    func testUpdateDataForExistingKey() throws {
        dataBase.updateData("Noche", "night", "es")
        sampleData["night"]?.updateValue("Noche", forKey: "es")
        XCTAssertTrue(dataBase.getData()! == sampleData)
    }

    func testDeleteDataByKeyAndLanguage() throws {
        let argumentsType = ArgumentsType.keyAndLanguage(valueOfKey: "day", valueOfLanguage: "en")
        dataBase.deleteData(argumentsType)
        sampleData["day"]?.removeValue(forKey: "en")
        XCTAssertTrue(dataBase.getData()! == sampleData)
    }

    func testDeleteDataByKeyAndLanguageForTheOnlyTranslation() throws {
        let argumentsType = ArgumentsType.keyAndLanguage(valueOfKey: "cat", valueOfLanguage: "en")
        dataBase.deleteData(argumentsType)
        sampleData.removeValue(forKey: "cat")
        XCTAssertTrue(dataBase.getData()! == sampleData)

    }

    func testDeleteDataByLanguage() throws {
        let argumentsType = ArgumentsType.language(value: "en")
        dataBase.deleteData(argumentsType)
        sampleData.removeValue(forKey: "cat")
        sampleData["day"]?.removeValue(forKey: "en")
        sampleData["night"]?.removeValue(forKey: "en")
        XCTAssertTrue(dataBase.getData()! == sampleData)
    }

    func testDeleteDataByKey() throws {
        let argumentsType = ArgumentsType.key(value: "day")
        dataBase.deleteData(argumentsType)
        sampleData.removeValue(forKey: "day")
        XCTAssertTrue(dataBase.getData()! == sampleData)
    }

    func testDeleteData() throws {
        let argumentsType = ArgumentsType.nothing
        dataBase.deleteData(argumentsType)
        XCTAssertTrue(dataBase.getData()! == sampleData)
    }

    static var allTests = [
        ("testGetData", testGetData),
        ("testUpdateDataForNewKey", testUpdateDataForNewKey),
        ("testUpdateDayaForExistingKey", testUpdateDataForExistingKey),
        ("testDeleteDataByKeyAndLanguage", testDeleteDataByKeyAndLanguage),
        ("testDeleteDataByKeyAndLanguage", testDeleteDataByKeyAndLanguageForTheOnlyTranslation),
        ("testDeleteDataByLanguage", testDeleteDataByLanguage),
        ("testDeleteDataByKey", testDeleteDataByKey),
        ("testDeleteData", testDeleteData)
    ]
}

