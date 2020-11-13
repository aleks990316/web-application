enum ArgumentsType {
    case key(value: String)
    case language(value: String)
    case keyAndLanguage(valueOfKey: String, valueOfLanguage: String)
    case nothing
}