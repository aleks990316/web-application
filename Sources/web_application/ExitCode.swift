public enum ExitCode {
    case success
    case error(code: Int32, _ description: String?)
}
 extension ExitCode: Equatable {
    public static func == (lhs: ExitCode, rhs: ExitCode) -> Bool {
        switch (lhs, rhs) {
            case (.success, .success):
                return true
            case (.error(let code1, _), .error(let code2, _)):
                if code1 == code2 {
                    return true
                } else {
                    return false
                }
            default:
                return false
        }
     }
 }
 