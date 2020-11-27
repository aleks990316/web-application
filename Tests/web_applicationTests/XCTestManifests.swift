import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ArgumentParserTests.allTests),
        testCase(DataBaseTests.allTests),
        testCase(FilterDataTests.allTests),
        testCase(ArgumentsFilterTests.allTests),
        testCase(PrinterTests.allTests)
    ]
}
#endif