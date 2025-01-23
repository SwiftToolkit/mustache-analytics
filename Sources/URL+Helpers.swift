//
//  File.swift
//  
//
//  Created by Natan Rolnik on 04/04/2024.
//

import Foundation

extension URL {
    func loadString() throws -> String {
        let data = try Data(contentsOf: self)
        guard let string = String(data: data, encoding: .utf8) else {
            fatalError("File \(self) is not a valid text file")
        }

        return string
    }
}
