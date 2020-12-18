@testable import web_application

import XCTest

final class ArgumentParserTests: XCTestCase {
    private var argumentsParser: ArgumentsParser!
    
    override func setUp() {
        argumentsParser = ArgumentsParser()
    }

    func testSearchWithKey() throws {
        guard let result = argumentsParser.parsing(["search", "-k", "day"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .search(let key, let language):
                XCTAssertEqual(key, "day")
                XCTAssertEqual(language, nil)
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testSearchWithLanguage() throws {
        guard let result = argumentsParser.parsing(["search", "-l", "en"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .search(let key, let language):
                XCTAssertEqual(key, nil)
                XCTAssertEqual(language, "en")

            default:
                XCTFail("Wrong parsing")
        }
    }

    func testSearchWithKeyAndLanguage() throws {
        guard let result = argumentsParser.parsing(["search", "-l", "en", "-k", "day"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .search(let key, let language):
                XCTAssertEqual(key, "day")
                XCTAssertEqual(language, "en")

            default:
                XCTFail("Wrong parsing")
        }
    }

    func testDefaultCommandWithKeyAndLanguage() throws {
        guard let result = argumentsParser.parsing(["-l", "en", "-k", "day"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .search(let key, let language):
                XCTAssertEqual(key, "day")
                XCTAssertEqual(language, "en")
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testSearchEmpty() throws {
        guard let result = argumentsParser.parsing(nil) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .search(let key, let language):
                XCTAssertEqual(key, nil)
                XCTAssertEqual(language, nil)
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testUpdateWithKeyAndLanguage() throws {
        guard let result = argumentsParser.parsing(["update", "Dog", "-k", "dog", "-l", "en"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .update(let word, let key, let language):
                XCTAssertEqual(word, "Dog")
                XCTAssertEqual(key, "dog")
                XCTAssertEqual(language, "en")
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testDeleteEmpty() throws {
        guard let result = argumentsParser.parsing(["delete"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .delete(let key, let language):
                XCTAssertEqual(key, nil)
                XCTAssertEqual(language, nil)
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testDeleteWithKey() throws {
        guard let result = argumentsParser.parsing(["delete", "-k", "dog"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .delete(let key, let language):
                XCTAssertEqual(key, "dog")
                XCTAssertEqual(language, nil)
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testDeleteWithLanguage() throws {
        guard let result = argumentsParser.parsing(["delete", "-l", "en"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .delete(let key, let language):
                XCTAssertEqual(key, nil)
                XCTAssertEqual(language, "en")
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testDeleteWithKeyAndLanguage() throws {
        guard let result = argumentsParser.parsing(["delete", "-k", "dog", "-l", "en"]) else {
            XCTFail("Parser has not returned results")
            return
        }

        switch result {
            case .delete(let key, let language):
                XCTAssertEqual(key, "dog")
                XCTAssertEqual(language, "en")
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testSearchHelp() throws {
        guard let result = argumentsParser.parsing(["search", "-h"]) else {
            XCTFail("Parser has not returned results")
            return
        }
        
        switch result {
            case .help(let message):
                XCTAssertTrue(message.hasPrefix("USAGE: search [-k <k>] [-l <l>]"))
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testUpdateHelp() throws {
        guard let result = argumentsParser.parsing(["update", "-h"]) else {
            XCTFail("Parser has not returned results")
            return
        }
        
        switch result {
            case .help(let message):
                XCTAssertTrue(message.hasPrefix("USAGE: update <word> -k <k> -l <l>"))
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testDeleteHelp() throws {
        guard let result = argumentsParser.parsing(["delete", "-h"]) else {
            XCTFail("Parser has not returned results")
            return
        }
        
        switch result {
            case .help(let message):
                XCTAssertTrue(message.hasPrefix("USAGE: delete [-k <k>] [-l <l>]"))
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testWrongCommand() throws {
        guard let result = argumentsParser.parsing(["destroy"]) else {
            XCTFail("Parser has not returned results")
            return
        }
        
        switch result {
            case .help(let message):
                XCTAssertTrue(message.hasPrefix("USAGE: commands <subcommand>"))
            default:
                XCTFail("Wrong parsing")
        }
    }

    func testWrongOption() {
        guard let result = argumentsParser.parsing(["search", "-m"]) else {
            XCTFail("Parser has not returned results")
            return
        }
        
        switch result {
            case .help(let message):
                XCTAssertTrue(message.hasPrefix("USAGE: search [-k <k>] [-l <l>]"))
            default:
                XCTFail("Wrong parsing")
        }
    }

    static var allTests = [
        ("testSearchWithKey", testSearchWithKey),
        ("testSearchWithLanguage", testSearchWithLanguage),
        ("testSearchWithKeyAndLanguage", testSearchWithKeyAndLanguage),
        ("testDefaultCommandWithKeyAndLanguage", testDefaultCommandWithKeyAndLanguage),
        ("testSearchEmpty", testSearchEmpty),
        ("testUpdateWithKeyAndLanguage", testUpdateWithKeyAndLanguage),
        ("testDeleteEmpty", testDeleteEmpty),
        ("testDeleteWithKey", testDeleteWithKey),
        ("testDeleteWithLanguage", testDeleteWithLanguage),
        ("testDeleteWithKeyAndLanguage", testDeleteWithKeyAndLanguage),
        ("testSearchHelp", testSearchHelp),
        ("testUpdateHelp", testUpdateHelp),
        ("testDeleteHelp", testDeleteHelp),
        ("testWrongCommand", testWrongCommand),
        ("testWrongOption", testWrongOption)
    ]
}