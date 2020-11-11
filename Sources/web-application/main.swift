import Foundation
import ArgumentParser
import PrettyColors
/*
func loadJson(filename fileName: String) ->  [String : [String : String]]? {
  if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
      do {
          let data = try Data(contentsOf: url)
          let decoder = JSONDecoder()
          let jsonData = try decoder.decode([String : [String : String]].self, from: data)
          return jsonData
      } catch {
        print("error:\(error)")
      }
  }
  return nil
}

func uploadJSON(fileName: String, words: [String : [String : String]]) {
  if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let json = try encoder.encode(words)
      try json.write(to: url)
    } catch {
      print("error: \(error)")
    }
  }
}

func outAll(words: [String : [String : String]]) {
  for (word, translation) in words {
  print(Color.Wrap(foreground: .yellow).wrap(word))
    for (language, literal) in translation {
      print(Color.Wrap(foreground: .green).wrap("\t\(language): "), terminator: " ")
      print(Color.Wrap(foreground: .blue).wrap("\(literal)"))
    }
  }
}

func outTranslations(wordIn: String, words: [String : [String : String]]) {
  if let word = words[wordIn.lowercased()] {
  print(wordIn)
    for (language, literal) in word {
      print(Color.Wrap(foreground: .green).wrap("\t\(language): "), terminator: " ")
      print(Color.Wrap(foreground: .blue).wrap("\(literal)"))  
    }
  } else {
    print(Color.Wrap(foreground: .red).wrap("Not found"))
  }
}

func outLiterals(languageIn: String, words: [String : [String : String]]) {
  var count = 0
  for (word, translation) in words {
    if let literal = translation[languageIn.lowercased()] {
      print(Color.Wrap(foreground: .cyan).wrap("\(word) = \(literal)"))
      count+=1
    }
  }
  if count == 0 {
    print(Color.Wrap(foreground: .red).wrap("Not found"))
  }
}

func outTranslation(wordIn: String, languageIn: String, words: [String : [String : String]]) {
  if let word = words[wordIn.lowercased()], let language = word[languageIn.lowercased()]{
  print(Color.Wrap(foreground: .magenta).wrap(language))
  } else {
    print(Color.Wrap(foreground: .red).wrap("Not found"))
  }
}

struct Dictionary: ParsableCommand {
  //кастомизируем аргумент для подсказки
  static var configuration = CommandConfiguration(
    abstract: "Dictionary",
    //подкоманды
    subcommands: [Search.self, Update.self, Delete.self],
    //команда по умолчанию
    defaultSubcommand: Search.self,
    helpNames: [.long, .short]
  )
}

extension Dictionary {
  //поиск по словарю
  struct Search: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Search throw dictionary")
    @Option (name: .short, help: "A word to search")
    var key: String?
    @Option (name: .short, help: "A language to search")
    var language: String?
    mutating func run() {
      if let words = loadJson(filename: "data") {
        if let k = key, let l = language {
          outTranslation(wordIn: k, languageIn: l, words: words)
        } else if let k = key {
         outTranslations(wordIn: k, words: words)
        } else if let l = language {
          outLiterals(languageIn: l, words: words)
        } else {
          outAll(words: words)
        }
      } else {
        print("Error download JSON")
      }
    }
  }
  //обновление словаря
  struct Update: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Add new data to dictionary")
    @Argument(help: "A word to update")
    var word: String
    @Option (name: .short, help: "translation")
    var key: String
    @Option (name: .short, help: "language")
    var language: String
    mutating func run() {
      if var words = loadJson(filename: "data") {
        //если слово уже есть в словаре, то добавить перевод
        if var w = words[key.lowercased()] {
            w.updateValue(word, forKey: language)
            words[key.lowercased()] = w
        } else {//если такого слова нет в словаре
          words[key.lowercased()] = [language:word]
        }
        uploadJSON(fileName: "data", words: words)
      } else {
        print("Error download JSON")
      }
    }
  }
  //удаление из словаря
  struct Delete: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Delete data fro dictionary")
    @Option (name: .short, help: "translation")
    var key: String?
    @Option (name: .short, help: "language")
    var language: String?
    mutating func run() {
      if var words = loadJson(filename: "data") {
        //удалям конкретный перевод для конкретного слова
        if let k = key, let l = language {
          //если слово есть в словаре
          if var word = words[k.lowercased()] {
            //если перевод есть в словаре
            guard let _ = word.removeValue(forKey: l.lowercased()) else {
              print("Not found")
              return
            }
            //ббновляем словарь
            words[k.lowercased()] = word
            //если какое-то из слов осталось без переводов, то удаляем его
            if words[k.lowercased()] == [:] {
              words.removeValue(forKey: k.lowercased())
            }
          } else {
            print("Not found")
          }
        } else if let k = key {//удалить все переводы для слова из словаря
          //если такое слово есть в словаре
          guard let _ = words.removeValue(forKey: k.lowercased()) else {
            print("Not found")
            return
          }
        } else if let l = language {//удалить все переводы на конкретном языке
          var count = 0 //счётчик для удлаенных переводов
          for (word, var translations) in words {
            //если перевод на таком языке есть
            if let _ = translations.removeValue(forKey: l.lowercased()) {
              count += 1
            }
            //обновляем словарь
            words[word] = translations
            //если переводов для слова не осталось, то удаляем его из словаря
            if words[word] == [:] {
              words.removeValue(forKey: word)
            }
          }
          //если ничего не найдено
          if count == 0 {
            print("Not found")
          }
        } else {
          print("Not found")
        }
        uploadJSON(fileName: "data", words: words)
      } else {
        print("Error download JSON")
      }
    }
  }
}

Dictionary.main()*/
enum Arguments {
  case search(key: String?, language: String?)
  case update(word: String, key: String, language: String)
  case delete(key: String?, language: String?)
  //case help(command: String?)
}

protocol ArgumentsParserProtocol {
  func parsing() -> Arguments?
}

class ArgumentsParser: ArgumentsParserProtocol {
  func parsing() -> Arguments? {
    do {
      let arguments = CommandLine.arguments
      let command = try Commands.parseAsRoot()
      switch command {
        case let command as Commands.Search:
          return .search(key: command.key, language: command.language)
        case let command as Commands.Update:
          return .update(word: command.word, key: command.key, language: command.language)
        case let command as Commands.Delete:
          return .delete(key: command.key, language: command.language)
        default:    
          if arguments[1] == "search" {
            print(Commands.Search.helpMessage())
          } else if arguments[1] == "update" {
            print(Commands.Update.helpMessage())
          } else if arguments[1] == "delete" {
            print(Commands.Delete.helpMessage())
          }
          return nil
      }
    }
    catch {
      print(Commands.helpMessage())
      return nil
    }
  }
}

private struct Commands: ParsableCommand {
  static var configuration = CommandConfiguration(
    subcommands: [Search.self, Update.self, Delete.self]
  )
}

extension Commands {
  struct Search: ParsableCommand {
    @Option(name: .short)
    var key: String?

    @Option(name: .short)
    var language: String?

  }

  struct Delete: ParsableCommand {
    @Option(name: .short)
    var key: String?

    @Option(name: .short)
    var language: String?
  }

  struct Update: ParsableCommand {
    @Argument 
    var word: String

    @Option(name: .short)
    var key: String

    @Option(name: .short)
    var language: String
  }
}

protocol DataBaseProtocol {
  func getData() -> [String: [String: String]]?
  func updateData(_ word: String, _ key: String, _ language: String)
  func deleteData(_ key: String?, _ language: String?)

}

class DataBase: DataBaseProtocol {

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

protocol FilterDataProtocol {
  func filterData(_ words: [String: [String: String]], _ key: String?, _ language: String?)
}

class Filter: FilterDataProtocol {
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

class Container {
  var argumentsParser: ArgumentsParserProtocol {
    return ArgumentsParser()
  }
  var dataBase: DataBaseProtocol {
    return DataBase()
  }
  var filter: FilterDataProtocol{
    return Filter()
  }
}

func main() {
  let container = Container()
  let parser = container.argumentsParser

  guard let arguments = parser.parsing() else {
    return
  }

  let dataBase = container.dataBase

  switch arguments {
    case .search(key: let key, language: let language):
      guard let data = dataBase.getData() else {
        return
      }
      let filter = container.filter
      filter.filterData(data, key, language)
    case .update(word: let word, key: let key, language: let language):
      dataBase.updateData(word, key, language)
    case .delete(key: let key, language: let language):
      dataBase.deleteData(key, language)
  }
  
  
}

main()