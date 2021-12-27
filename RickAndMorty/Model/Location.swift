//
//  Location.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import Foundation

struct Location: Decodable {

    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents:[String]
    let url: String


}
