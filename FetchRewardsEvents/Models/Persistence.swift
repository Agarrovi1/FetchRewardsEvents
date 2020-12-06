//
//  Persistence.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/6/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import Foundation
class Persistence {
    static let shared = Persistence()
    
    func getObjects() throws -> [Int] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([Int].self, from: data)
    }
    
    func save(_ newElement: Int) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func delete(_ element: Int) throws {
        var elements = try getObjects()
        let index = elements.firstIndex(of: element)
        if let index = index {
            elements.remove(at: index)
        }
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    init() {}
    
    private let fileName = "eventFile"
    
    private var url: URL {
        return filePathFromDocumentsDirectory(filename: fileName)
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func filePathFromDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}


