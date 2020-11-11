import PrettyColors

protocol FilterDataProtocol {
  func filterData(_ words: [String: [String: String]], _ key: String?, _ language: String?)
}

class FilterData: FilterDataProtocol {
  func filterData(_ words: [String: [String: String]], _ key: String?, _ language: String?) {
    if let language = language?.lowercased() {
      var result: [String: String] = [:]
      for (word, translations) in words {
        if let translation = translations[language] {
        result.updateValue(translation, forKey: word)
        }
      }
      if let key = key?.lowercased() {
        guard let translation = result[key] else {
          print(Color.Wrap(foreground: .red).wrap("No data found"))
          return
        }
        print(Color.Wrap(foreground: .magenta).wrap(translation))
      } else {
        guard !result.isEmpty else {
          print(Color.Wrap(foreground: .red).wrap("No data found"))
          return
        }
        for (word, translation) in result {
          print(Color.Wrap(foreground: .cyan).wrap("\(word) = \(translation)"))
        }
      }
    } else {
      var result: [String: [String: String]] = [:]
      if let key = key?.lowercased() {
        guard let word = words[key] else {
          print("No data found")
          return
        }
        result.updateValue(word, forKey: key)
      } else {
        result = words
      }
      guard !result.isEmpty else {
        print(Color.Wrap(foreground: .red).wrap("No data found"))
        return
      }
      for (word, translations) in result {
        print(Color.Wrap(foreground: .yellow).wrap(word))
        for (language, translation) in translations {
          print(Color.Wrap(foreground: .green).wrap("\t\(language): "), terminator: " ")
          print(Color.Wrap(foreground: .blue).wrap("\(translation)"))
        }
      }
    }
  }
}