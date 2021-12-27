//
//  StorageController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

class StorageController {
    private let decoder = JSONDecoder()
    private var characters: [Character] = []
    private var locationsCache: [String : Location] = [:]

    func charCount() -> Int {
        return characters.count
    }

    func parseCharacters(from data: Data) throws {
        let chars = try decoder.decode([Character].self, from: data)
        characters.append(contentsOf: chars)
    }

    func parseLocation(from data: Data) throws -> Location {
        let location: Location = try decoder.decode(Location.self, from: data)
        locationsCache[location.name] = location
        return location
    }

    func getCharacterAt(index: Int) -> Character {
        return characters[index]
    }

    func getLocationBy(name: String) -> Location? {
        return locationsCache[name]
    }


}
