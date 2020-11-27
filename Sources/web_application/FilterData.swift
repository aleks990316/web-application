protocol FilterDataProtocol {
  func filter(_ arguments: ArgumentsType) -> String
}

class FilterData: FilterDataProtocol {
  private let dataBase: DataBaseProtocol
  private var data: [String: [String: String]]? {
    return dataBase.getData()
  }
  private var result: String = ""

  private func filterByKeyAndLanguage(_ key: String, _ language: String) -> String {
    if let data = data {
      if let translations = data[key]{
        if let translation = translations[language] {
          result += translation
        }
      }
    }
    return result
  }

  private func filterByKey(_ key: String) -> String {
    if let data = data {
      if let translations = data[key] {
        result += key + ":\n"
        for (language, translation) in translations {
          result += "\t" + language + ": " + translation + "\n"
        }
      }
    }
    return result
  }

  private func filterByLanguage(_ language: String) -> String {
    if let data = data {
      for (word, translations) in data {
        if let translation = translations[language] {
          result += word + " = " + translation + "\n"
        }
      }
    }
    return result
  }

  private func getAll() -> String {
    if let data = data {
      for (word, translations) in data {
        result += word + ":\n"
        for (language, translation) in translations {
          result += "\t" + language + ": " + translation + "\n"
        }
      }
    } 
    return result
  }

  func filter(_ arguments: ArgumentsType) -> String {
    switch arguments {
      case .keyAndLanguage(valueOfKey: let key, valueOfLanguage: let language):
        return filterByKeyAndLanguage(key, language)
      case .language(value: let language):
        return filterByLanguage(language)
      case .key(value: let key):
        return filterByKey(key)
      case .nothing:
        return getAll()
    }
  }

  init(dataBase: DataBaseProtocol) {
    self.dataBase = dataBase
  }
}