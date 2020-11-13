import PrettyColors

protocol PrinterProtocol {
    func printing(_ string: String)
}

class Printer: PrinterProtocol {
    func printing(_ string: String) {
        if string != "" {
            print(Color.Wrap(foreground: .blue).wrap(string))
        } else {
            print(Color.Wrap(foreground: .red).wrap("No data found"))
        }
    }
}