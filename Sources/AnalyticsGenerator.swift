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

        let outputPath = FileManager.default.currentDirectoryPath + "/Events.swift"
        try generatedCode.write(
            to: URL(fileURLWithPath: outputPath),
            atomically: true,
            encoding: .utf8
        )
    }

    func loadEvents() throws -> [AnalyticEvent] {
        let inputPath = FileManager.default.currentDirectoryPath + "/" + input
        let eventsTable = try URL(fileURLWithPath: inputPath).loadString()
        return try MarkDecoder().decode([AnalyticEvent].self, from: eventsTable)
    }

    func generate(using events: [AnalyticEvent]) throws -> String {
        guard let templateURL = Bundle.module
            .url(forResource: "EventsSwift", withExtension: ".mustache") else {
            fatalError("Template file not found")
        }

        let templateString = try templateURL.loadString()
        let template = try MustacheTemplate(string: templateString)

        return template.render(["events": events])
    }
}
