import Vapor

struct ControllerSearch: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("search")
        group.get(use: search)
    }

    func search(req: Request) throws -> EventLoopFuture<String> {
        let parametres = try? req.query.decode(Parameters.self)
        var query = ["search"]
        req.logger.info("Parametres: \(parametres?.key ?? "") \(parametres?.language ?? "")")
        let key = parametres?.key
        let language = parametres?.language
        if let key = key {
            query += ["-k", key]
        }
        if let language = language {
            query += ["-l", language]
        }
        let exitCode = main(query)
        switch exitCode {
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