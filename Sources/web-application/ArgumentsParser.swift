import ArgumentParser

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
