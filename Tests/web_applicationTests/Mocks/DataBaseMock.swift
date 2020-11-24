@testable import web_application

class DataBaseMock: DataBaseProtocol {

    var numberOfCallsGetData = 0
    var numberOfCallsUpdateData = 0
    var numberOfCallsDeleteData = 0
    var sampleData: [String: [String: String]]? = ["day": ["en": "Day", "ru": "День"], "night": ["en": "Night", "ru": "Ночь"], "cat": ["en": "Cat"]]

    func getData() -> [String: [String: String]]? {
        numberOfCallsGetData += 1

        return sampleData
    }

    func updateData(_ word: String, _ key: String, _ language: String) -> ExitCode {
        numberOfCallsUpdateData += 1
        return .success
    }
    
    func deleteData(_ arguments: ArgumentsType) -> ExitCode {
        numberOfCallsDeleteData += 1
        return .success
    }

    init(data: [String: [String: String]]?) {
        sampleData = data
    }

    init() {

    }
}
