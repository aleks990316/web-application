import Vapor

struct ControllerUpdate: RouteCollection {
    let container: Container
    
    init() {
        container = Container()
    }

    func boot(routes: RoutesBuilder) throws {
        let group = routes.grouped("update")
        group.get(use: update)
    }

    func update(req: Request) throws -> EventLoopFuture<String> {
        let parametres = try? req.query.decode(Parameters.self)
        req.logger.info("Parametres: \(parametres?.key ?? "") \(parametres?.language ?? "") \(parametres?.word ?? "")")
        guard let key = parametres?.key, let language = parametres?.language, let word = parametres?.word else {
            return req.eventLoop.future("Не все параметры переданы")
        }
        let dataBase = container.dataBase
        let result = dataBase.updateData(word, key.lowercased(), language.lowercased())
        switch result {
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