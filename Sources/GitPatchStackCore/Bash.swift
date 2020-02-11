import Foundation

public class Bash {
    public enum Error: Swift.Error {
        case commandNotFound
        case outputExpectedButMissing
    }

    private let path: String

    public init(_ path: String? = nil) {
        if let p = path {
            self.path = p
        } else {
            self.path = "/bin/bash"
        }
    }

    func which(_ commandName: String) throws -> String {
        let result = try run(self.path, arguments: ["-l", "-c", "which \(commandName)"])
        if result.terminationStatus == 0 {
            if let path = result.standardOutput {
                return path.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                throw Error.outputExpectedButMissing
            }
        } else {
            throw Error.commandNotFound
        }
    }
}
