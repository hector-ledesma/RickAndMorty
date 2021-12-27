//
//  Page.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation


struct Page<T: Decodable>: Decodable {
    struct PageInfo: Decodable {
        let count: Int
        let pages: Int
    }
    let info: PageInfo
    let results: [T]
}
