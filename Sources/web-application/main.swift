import Foundation
import ArgumentParser
import PrettyColors

func loadJson(filename fileName: String) ->  [String:[String:String]]? {
    if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([String: [String:String]].self, from: data)
            return jsonData
        }catch {
            print("error:\(error)")
        }
    }
    return nil
}

func uploadJSON(fileName: String, _ words: inout [String: [String:String]]){
  if let url = Bundle.module.url(forResource: fileName, withExtension: "json"){
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let json = try encoder.encode(words)
      print(json)
      try json.write(to: url)
    }catch{
      print("error: \(error)")
    }
  }
}

func outAll(_ words: inout [String: [String:String]]){
  for (word, translation) in words{
  print(Color.Wrap(foreground: .yellow).wrap(word))
    for (language, literal) in translation{
      print(Color.Wrap(foreground: .green).wrap("\t\(language): "), terminator: " ")
      print(Color.Wrap(foreground: .blue).wrap("\(literal)"))
    }
  }
}

func outTranslations(word_in: String, _ words: inout [String: [String:String]]){
  if let word = words[word_in.lowercased()]{
  print(word_in)
    for (language, literal) in word{
      print(Color.Wrap(foreground: .green).wrap("\t\(language): "), terminator: " ")
      print(Color.Wrap(foreground: .blue).wrap("\(literal)"))  
    }
  }else{
    print(Color.Wrap(foreground: .red).wrap("Not found"))
  }
}

func outLiterals(language_in: String, _ words: inout [String: [String:String]]){
  var count = 0
  for (word, translation) in words{
    if let literal = translation[language_in.lowercased()] {
      print(Color.Wrap(foreground: .cyan).wrap("\(word) = \(literal)"))
      count+=1
    }
  }
  if count == 0{
    print(Color.Wrap(foreground: .red).wrap("Not found"))
  }
}

func outTranslation(word_in: String, language_in: String, _ words: inout [String: [String:String]]){
  if let word = words[word_in.lowercased()], let language = word[language_in.lowercased()]{
  print(Color.Wrap(foreground: .magenta).wrap(language))
  }else{
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

extension Dictionary{
  //поиск по словарю
  struct Search: ParsableCommand{
    static var configuration = CommandConfiguration(abstract: "Search throw dictionary")
    @Option (name: .short, help: "A word to search")
    var key: String?
    @Option (name: .short, help: "A language to search")
    var language: String?
    mutating func run(){
      if var words = loadJson(filename: "data"){
        if let k = key, let l = language{
          outTranslation(word_in: k, language_in: l, &words)
        }
        else if let k = key{
          outTranslations(word_in: k, &words)
        }
        else if let l = language{
          outLiterals(language_in: l, &words)
        }
        else{
          outAll(&words)
        }
      }else{
        print("Error download JSON")
      }
    }
  }
  //обновление словаря
  struct Update: ParsableCommand{
    static var configuration = CommandConfiguration(abstract: "Add new data to dictionary")
    @Argument(help: "A word to update")
    var word: String
    @Option (name: .short, help: "translation")
    var key: String
    @Option (name: .short, help: "language")
    var language: String
    mutating func run(){
      if var words = loadJson(filename: "data"){
        //если слово уже есть в словаре, то добавить перевод
        if var w = words[key.lowercased()]{
            w.updateValue(word, forKey: language)
            words[key.lowercased()] = w
        }else{//если такого слова нет в словаре
          words[key.lowercased()] = [language:word]
        }
        uploadJSON(fileName: "data", &words)
      }else{
        print("Error download JSON")
      }
    }
  }
  //удаление из словаря
  struct Delete: ParsableCommand{
    static var configuration = CommandConfiguration(abstract: "Delete data fro dictionary")
    @Option (name: .short, help: "translation")
    var key: String?
    @Option (name: .short, help: "language")
    var language: String?
    mutating func run(){
      if var words = loadJson(filename: "data"){
        //удалям конкретный перевод для конкретного слова
        if let k = key, let l = language{
          //если слово есть в словаре
          if var word = words[k.lowercased()]{
            //если перевод есть в словаре
            guard let _ = word.removeValue(forKey: l.lowercased()) else{
              print("Not found")
              return
            }
            //ббновляем словарь
            words[k.lowercased()] = word
            //если какое-то из слов осталось без переводов, то удаляем его
            if words[k.lowercased()] == [:]{
              words.removeValue(forKey: k.lowercased())
            }
          }else{
            print("Not found")
          }
        }else if let k = key{//удалить все переводы для слова из словаря
          //если такое слово есть в словаре
          guard let _ = words.removeValue(forKey: k.lowercased()) else{
            print("Not found")
            return
          }
        }else if let l = language{//удалить все переводы на конкретном языке
          var count = 0 //счётчик для удлаенных переводов
          for (word, var translations) in words{
            //если перевод на таком языке есть
            if let _ = translations.removeValue(forKey: l.lowercased()){
              count += 1
            }
            //обновляем словарь
            words[word] = translations
            //если переводов для слова не осталось, то удаляем его из словаря
            if words[word] == [:]{
              words.removeValue(forKey: word)
            }
          }
          //если ничего не найдено
          if count == 0{
            print("Not found")
          }
        }else{
          print("Not found")
        }
        print(words)
        uploadJSON(fileName: "data", &words)
      }else{
        print("Error download JSON")
      }
    }
  }
}

Dictionary.main()