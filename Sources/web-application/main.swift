import Foundation
func main(){
  let container = Container()
  let parser = container.argumentsParser

  guard let arguments = parser.parsing() else {
    exit(-1)
  }
  
  var result: Int32

  switch arguments {
    case .search(key: let key, language: let language):
      let argumentsFilter = container.filterOfArguments
      let keys = argumentsFilter.filter(key, language)
      let dataFilter = container.filterData
      let filteredData = dataFilter.filter(keys)
      let printer = container.printer
      result = printer.printing(filteredData)
      exit(result)
    case .update(word: let word, key: let key, language: let language):
      let dataBase = container.dataBase
      result = dataBase.updateData(word, key.lowercased(), language.lowercased())
      exit(result)
    case .delete(key: let key, language: let language):
      let argumentsFilter = container.filterOfArguments
      let keys = argumentsFilter.filter(key, language)
      let dataBase = container.dataBase
      result = dataBase.deleteData(keys)
      exit(result)
    case .help(message: let message):
      let printer = container.printer
      result = printer.printing(message)
      result += 7
      exit(result)
  }
}

main()