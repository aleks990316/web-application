@testable import web_application

class DataBaseMock: DataBaseProtocol {
    func getData() -> [String: [String: String]]? {
        let sampleData = ["day": ["en": "Day", "ru": "День"], "night": ["en": "Night", "ru": "Ночь"], "cat": ["en": "Cat"]]
        return sampleData
    }

    func updateData(_ word: String, _ key: String, _ language: String) -> Int32 {
        return 0
    }
    
    func deleteData(_ arguments: ArgumentsType) -> Int32 {
        return 0
    }
}
