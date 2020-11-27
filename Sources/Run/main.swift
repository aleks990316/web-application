import web_application
import Foundation
let exitCode = main()
switch exitCode {
    case .error(code: let code, _):
        exit(code)
    case .success:
        exit(0)
}