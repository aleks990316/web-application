import Foundation
import ArgumentParser
import PrettyColors
struct Dict: Codable{
  let words: [String:[String:String]]?
}
func loadJson(filename fileName: String) ->  [String:[String:String]]? {
    if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Dict.self, from: data)
            return jsonData.words
        }catch {
            print("error:\(error)")
        }
    }
    return nil
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
  static let configuration = CommandConfiguration(
    helpNames: [.long, .short]
  )
  //делаем опционалы, потому что это необязательные аргументы
  //программа может быть запущена и без них
  @Option (name: .short, help: "A word to translate")
  var kArgument: String?
  @Option (name: .short, help: "A language to choose")
  var lArgument: String?
  mutating func run() throws {
    if var words = loadJson(filename: "data"){
      if let k = kArgument, let l = lArgument{
        outTranslation(word_in: k, language_in: l, &words)
      }
      else if let k = kArgument{
        outTranslations(word_in: k, &words)
      }
      else if let l = lArgument{
        outLiterals(language_in: l, &words)
      }
      else{
        outAll(&words)
      }
    }else{
      print("Error JSON")
    }
  }
}

Dictionary.main()