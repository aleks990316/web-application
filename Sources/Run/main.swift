import web_application
import Foundation
let exitCode = main()
switch exitCode {
    case .error(code: let code):
        exit(code)
    case .success:
        exit(0)
}