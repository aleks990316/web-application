class Container {
  var argumentsParser: ArgumentsParserProtocol {
    return ArgumentsParser()
  }
  var dataBase: DataBaseProtocol {
    return DataBase()
  }
  var filterData: FilterDataProtocol{
    return FilterData(dataBase: dataBase)
  }
  var filterOfArguments: ArgumentsFilterProtocol {
    return ArgumentsFilter()
  }

  var printer: PrinterProtocol {
    return Printer()
  }
}