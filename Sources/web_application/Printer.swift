protocol PrinterProtocol {
    func printing(_ string: String) -> ExitCode
}

class Printer: PrinterProtocol {
    func printing(_ string: String) -> ExitCode {
        if string != "" {
            print(string)
            return .success
        } else {
            print("No data found")
            return .error(code: 1, "No data found")
        }
    }
}