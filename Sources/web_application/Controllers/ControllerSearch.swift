import Vapor

struct ControllerSearch: RouteCollection {

    let container: Container 

    init() {
        container = Container()
    }
    
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("search")
        group.get(use: search)
    }

    func search(req: Request) throws -> EventLoopFuture<String> {
        let parametres = try? req.query.decode(Parameters.self)
        req.logger.info("Parametres: \(parametres?.key ?? "") \(parametres?.language ?? "")")
        let key = parametres?.key
        let language = parametres?.language
        let argumentsFilter = container.filterOfArguments
        let keys = argumentsFilter.filter(key, language)
        let dataFilter = container.filterData
        let filteredData = dataFilter.filter(keys)
        let printer = container.printer
        let result = printer.printing(filteredData)
        switch result {
        case .success(answer: let answer):
            return req.eventLoop.future(answer ?? "")
        case .error(code: let code, let description):
            return req.eventLoop.future("\(code) \(description ?? "")")
        }
    }
}

private extension ControllerSearch {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
} 