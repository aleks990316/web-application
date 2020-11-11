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