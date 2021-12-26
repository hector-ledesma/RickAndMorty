//
//  Character.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import Foundation

typealias CharacterLocation = DataObject
typealias CharacterOrigin = DataObject

struct Character: Decodable {

    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: URL
    let episode: [URL]


}
