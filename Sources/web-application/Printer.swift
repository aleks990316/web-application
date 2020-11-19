protocol PrinterProtocol {
    func printing(_ string: String) -> Int32
}

class Printer: PrinterProtocol {
    func printing(_ string: String) -> Int32 {
        if string != "" {
            print(string)
            return 0
        } else {
            print("No data found")
            return 1
        }
    }
}