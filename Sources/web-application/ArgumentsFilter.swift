protocol ArgumentsFilterProtocol {
    func filter(_ key: String?, _ language: String?) -> ArgumentsType
}

class ArgumentsFilter: ArgumentsFilterProtocol {
    func filter(_ key: String?, _ language: String?) -> ArgumentsType {
        if let key = key, let language = language {
            return .keyAndLanguage(valueOfKey: key.lowercased(), valueOfLanguage: language.lowercased())
        } else if let key = key {
            return .key(value: key.lowercased())
        } else if let language = language{
            return .language(value: language.lowercased())
        } else {
            return .nothing
        }
    }
}