func main() {
  let container = Container()
  let parser = container.argumentsParser

  guard let arguments = parser.parsing() else {
    return
  }

  switch arguments {
    case .search(key: let key, language: let language):
      let argumentsFilter = container.filterOfArguments
      let keys = argumentsFilter.filter(key, language)
      let dataFilter = container.filterData
      let filteredData = dataFilter.filter(keys)
      let printer = container.printer
      printer.printing(filteredData)
    case .update(word: let word, key: let key, language: let language):
      let dataBase = container.dataBase
      dataBase.updateData(word, key.lowercased(), language.lowercased())
    case .delete(key: let key, language: let language):
      let argumentsFilter = container.filterOfArguments
      let keys = argumentsFilter.filter(key, language)
      let dataBase = container.dataBase
      dataBase.deleteData(keys)
    case .help(message: let message):
      let printer = container.printer
      printer.printing(message)
      
  }
}

main()