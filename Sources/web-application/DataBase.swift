import PrettyColors
import Foundation

protocol DataBaseProtocol {
  func getData() -> [String: [String: String]]?
  func updateData(_ word: String, _ key: String, _ language: String)
  func deleteData(_ arguments: ArgumentsType)
}

class DataBase: DataBaseProtocol{

  private var data: [String: [String: String]]?

  func getData() -> [String: [String: String]]? {
    return data
  }
  
  func updateData(_ word: String, _ key: String, _ language: String){
    if data?[key] == nil { 
      data?.updateValue([language: word], forKey: key)
    } else {
      data?[key]?.updateValue(word, forKey: language)
    }
    uploadJSON(fileName: "data")
  }

  private func deleteByKeyAndLanguage(_ key: String, _ language: String) {
    guard var word = data?[key] else {
        print(Color.Wrap(foreground: .red).wrap("No data found"))
        return
    }
    guard let _ = word[language] else {
        print(Color.Wrap(foreground: .red).wrap("No data found"))
        return
    }
    word.removeValue(forKey: language)
    if word.isEmpty{
      data?.removeValue(forKey: key)
    }
  }

  private func deleteByLanguage(_ language: String) {
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
        print(Color.Wrap(foreground: .red).wrap("No data found"))
      } else {
        data = copyOfData
      }
    }
  }

  func deleteByKey(_ key: String) { 
    if data?.removeValue(forKey: key) == nil {
      print(Color.Wrap(foreground: .red).wrap("No data found"))
    } 
  }

  func deleteData(_ arguments: ArgumentsType) {
    switch arguments {
      case .keyAndLanguage(valueOfKey: let key, valueOfLanguage: let language):
        deleteByKeyAndLanguage(key, language)
      case .language(value: let language):
        deleteByLanguage(language)
      case .key(value: let key):
        deleteByKey(key)
      case .nothing:
        print(Color.Wrap(foreground: .red).wrap("No data found"))
    }
    uploadJSON(fileName: "data")
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

  init () {
    data = loadJson(filename: "data")
  }
}