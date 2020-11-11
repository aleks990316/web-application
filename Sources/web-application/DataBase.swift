import PrettyColors
import Foundation

protocol DataBaseProtocol {
  func getData() -> [String: [String: String]]?
  func updateData(_ word: String, _ key: String, _ language: String)
  func deleteData(_ key: String?, _ language: String?)

}

class DataBase: DataBaseProtocol, Codable {

  private var words: [String: [String: String]]? = DataBase.loadJson(filename: "data")

  func getData() -> [String: [String: String]]?{
    return words
  }
  func updateData(_ word: String, _ key: String, _ language: String){
    if words?[key] == nil { 
      words?.updateValue([language: word], forKey: key)
    } else {
      words?[key]?.updateValue(word, forKey: language)
    }
    uploadJSON(fileName: "data")
  }

  func deleteData(_ key: String?, _ language: String?) {
    if let key = key{
      guard var word = words?[key] else {
        print(Color.Wrap(foreground: .red).wrap("No data found"))
        return
      }
      if let language = language {
        guard let _ = word[language] else {
          print(Color.Wrap(foreground: .red).wrap("No data found"))
          return
        }
        word.removeValue(forKey: language)
      } else {
        word = [:]
      }
      words?[key] = word
      if words?[key] == [:] {
        words?.removeValue(forKey: key)
      } 
    } else if let language = language {
      guard var data = words else {
        return
      }
      for (word, var translations) in data {
        translations.removeValue(forKey: language)
        data[word] = translations 
        if data[word] == [:] {
          data.removeValue(forKey: word)
        }
      }
      if data == words {
        print(Color.Wrap(foreground: .red).wrap("No data found"))
      } else {
        words = data
      }
    } else {
      print(Color.Wrap(foreground: .red).wrap("No data found"))
    }
    uploadJSON(fileName: "data")
  }

  class private func loadJson(filename fileName: String) ->  [String: [String: String]]? {
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
        let json = try encoder.encode(self.words)
        try json.write(to: url)
      } catch {
        print("error: \(error)")
      }
    }
  }
}