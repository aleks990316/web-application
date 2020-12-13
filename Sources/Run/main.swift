import web_application
import Foundation
let exitCode = main(nil)
switch exitCode {
    case .error(code: let code, let description):
        print("\(code) \(description ?? "")")
        exit(code)
    case .success(answer: let answer):
        print(answer ?? "")
        exit(0)
}