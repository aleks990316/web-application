import Vapor

struct ControllerDelete: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("delete")
        group.get(use: search)
    }

    func search(req: Request) throws -> EventLoopFuture<String> {
        let parametres = try? req.query.decode(Parameters.self)
        req.logger.info("Parametres: \(parametres?.key ?? "") \(parametres?.language ?? "")")
        let key = parametres?.key
        let language = parametres?.language
        let container = Container()
        let argumentsFilter = container.filterOfArguments
        let keys = argumentsFilter.filter(key, language)
        let dataBase = container.dataBase
        let result = dataBase.deleteData(keys)
        switch result {
        case .success(answer: let answer):
            return req.eventLoop.future(answer ?? "")
        case .error(code: let code, let description):
            return req.eventLoop.future("\(code) \(description ?? "")")
        }
    }
}

private extension ControllerDelete {
    struct Parameters: Content {
        let key: String?
        let language: String?
    }
} 