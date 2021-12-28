//
//  CharacterResource.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

enum CharacterResource {
    case page(number: Int)
    case id(_ id: Int)
    case imageFor(character: Character)
}

extension CharacterResource: ResourceRequestType {
    var requestURL: String {
        switch self {
        case .imageFor(character: let character):
            return character.image
        default:
            return "\(baseURL)\(resource.rawValue)\(queries)"
        }

    }

    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }

    var resource: APIResourceEndpoint {
        return .character
    }

    var queries: String {
        switch self {
        case .page(number: let number):
            return "?page=\(number)"
        case .id(_: let id):
            return "/\(id)"
        default:
            return ""
        }
    }

    var httpMethod: HTTPMethodType {
        return .get
    }

}
