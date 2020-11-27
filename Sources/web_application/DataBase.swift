import Foundation

protocol DataBaseProtocol {
  func getData() -> [String: [String: String]]?
  func updateData(_ word: String, _ key: String, _ language: String) -> ExitCode
  func deleteData(_ arguments: ArgumentsType) -> ExitCode
}

class DataBase: DataBaseProtocol{

  private var data: [String: [String: String]]?

  func getData() -> [String: [String: String]]? {
    return data
  }
  
  func updateData(_ word: String, _ key: String, _ language: String) -> ExitCode {
    if data?[key] == nil { 
      data?.updateValue([language: word], forKey: key)
    } else {
      data?[key]?.updateValue(word, forKey: language)
    }
    uploadJSON(fileName: "data")
    return .success
  }

  private func deleteByKeyAndLanguage(_ key: String, _ language: String) -> ExitCode {
    guard var word = data?[key] else {
        print("No data found")
        return .error(code: 3, "No data found")
    }
    guard let _ = word[language] else {
        print("No data found")
        return .error(code: 3, "No data found")
    }
    word.removeValue(forKey: language)
    if word.isEmpty{
      data?.removeValue(forKey: key)
    } else {
      data?[key]?.removeValue(forKey: language)
    }
    return .success
  }

  private func deleteByLanguage(_ language: String) -> ExitCode {
    var result: Int32 = -1
    if var copyOfData = data {
      for (word, var translations) in copyOfData {
        if let _ = translations[language] {
          translations.removeValue(forKey: language)
          if translations == [:] {
            copyOfData.removeValue(forKey: word)
          } else {
            copyOfData[word] = translations
          }
        }
      }
      if data == copyOfData {
        print("No data found")
        result = 3
      } else {
        data = copyOfData
        result = 0
      }
    }
    if result == 0 {
      return .success
    } else {
      return .error(code: result, "No data found")
    }
  }

  private func deleteByKey(_ key: String) -> ExitCode { 
    if data?.removeValue(forKey: key) == nil {
      print("No data found")
      return .error(code: 3, "No data found")
    } 
    return .success
  }

  func deleteData(_ arguments: ArgumentsType) -> ExitCode {
    let result: ExitCode
    switch arguments {
      case .keyAndLanguage(valueOfKey: let key, valueOfLanguage: let language):
        result = deleteByKeyAndLanguage(key, language)
      case .language(value: let language):
        result = deleteByLanguage(language)
      case .key(value: let key):
        result = deleteByKey(key)
      case .nothing:
        print("No data found")
        result = .error(code: 3, "No data found")
    }
    uploadJSON(fileName: "data")
    return result
  }

  private func loadJson(filename fileName: String) ->  [String: [String: String]]? {
    if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode([String : [String: String]].self, from: data)
        return jsonData
      } catch {
        return nil
      }
    }
    return nil
  }

  private func uploadJSON(fileName: String) {
    if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
      do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let json = try encoder.encode(self.data)
        try json.write(to: url)
      } catch {
        print("error: \(error)")
      }
    }
  }

  init() {
    data = loadJson(filename: "data")
  }

  init(data: [String: [String: String]]?) {
    self.data = data
  }
}