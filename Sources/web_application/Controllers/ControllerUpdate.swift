import Vapor

struct ControllerUpdate: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("update")
        group.get(use: update)
    }

    func update(req: Request) throws -> EventLoopFuture<String> {
        let parametres = try? req.query.decode(Parameters.self)
        var query = ["update"]
        req.logger.info("Parametres: \(parametres?.key ?? "") \(parametres?.language ?? "") \(parametres?.word ?? "")")
        let key = parametres?.key
        let language = parametres?.language
        let word = parametres?.word
        if let word = word {
            query.append(word)
        }
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

private extension ControllerUpdate {
    struct Parameters: Content {
        let word: String
        let key: String
        let language: String
    }
} 