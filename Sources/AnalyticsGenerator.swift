import ArgumentParser
import Foundation
import MarkCodable
import Mustache

@main
struct AnalyticsGenerator: ParsableCommand {
    @Option(name: .shortAndLong)
    var input: String

    @Option
    var format: Format

    func run() throws {
        let events = try loadEvents()
        let generatedCode = try generate(using: events)

        let outputPath = FileManager.default.currentDirectoryPath + "/Events." + format.fileExtension
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
            .url(forResource: format.templateName, withExtension: ".mustache") else {
            fatalError("Template file not found")
        }

        let templateString = try templateURL.loadString()
        let template = try MustacheTemplate(string: templateString)

        return template.render(["events": events])
    }
}

extension AnalyticsGenerator {
    enum Format: String, ExpressibleByArgument {
        case swift
        case kotlin
    }
}

extension AnalyticsGenerator.Format {
    var templateName: String {
        switch self {
        case .swift: "EventsSwift"
        case .kotlin: "EventsKotlin"
        }
    }

    var fileExtension: String {
        switch self {
        case .swift: "swift"
        case .kotlin: "kt"
        }
    }
}
