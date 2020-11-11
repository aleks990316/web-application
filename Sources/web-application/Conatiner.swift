class Container {
  var argumentsParser: ArgumentsParserProtocol {
    return ArgumentsParser()
  }
  var dataBase: DataBaseProtocol {
    return DataBase()
  }
  var filter: FilterDataProtocol{
    return FilterData()
  }
}