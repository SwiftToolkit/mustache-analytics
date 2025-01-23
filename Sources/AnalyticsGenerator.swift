import ArgumentParser
import Foundation
import MarkCodable
import Mustache

@main
struct AnalyticsGenerator: ParsableCommand {
    @Option(name: .shortAndLong)
    var input: String

    func run() throws {
        let events = try loadEvents()
        let generatedCode = try generate(using: events)

        // TODO: save the generated file
    }

    func loadEvents() throws -> [AnalyticEvent] {
        // TODO: implement loading the events from the input parameter
        []
    }

    func generate(using events: [AnalyticEvent]) throws -> String {
        // TODO: generate code using the template and passing the events
        ""
    }
}
