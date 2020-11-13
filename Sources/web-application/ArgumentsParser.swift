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
            return .help(message: Commands.Search.helpMessage())
          } else if arguments[1] == "update" {
            return .help(message: Commands.Update.helpMessage())
          } else if arguments[1] == "delete" {
            return .help(message: Commands.Delete.helpMessage())
          }
          //search -  команда по умолчанию
          return .help(message: Commands.Search.helpMessage())
      }
    }
    catch {
      return Arguments.help(message: Commands.helpMessage())
    }
  }
}

private struct Commands: ParsableCommand {
  static var configuration = CommandConfiguration(
    subcommands: [Search.self, Update.self, Delete.self],
    defaultSubcommand: Search.self
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
