//
//  File.swift
//  
//
//  Created by Natan Rolnik on 04/04/2024.
//

import Foundation

struct AnalyticEvent: Decodable {
    let name: String
    let description: String
    let fields: [String]

    private enum CodingKeys: String, CodingKey {
        case name
        case description
        case fields
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        fields = try container.decode(String.self, forKey: .fields)
            .components(separatedBy: ",")
    }
}
