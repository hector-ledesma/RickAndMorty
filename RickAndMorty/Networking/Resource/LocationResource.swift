//
//  LocationResource.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

enum LocationResource {
    case page(number: Int)
    case id(_ id: Int)
    case url(_ url: String)
}

extension LocationResource: ResourceRequestType {
    var requestURL: String {
        switch self {
        case .url(_: let url):
            return url
        default:
            return "\(baseURL)\(resource.rawValue)\(queries)"
        }
    }

    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }

    var resource: APIResourceEndpoint {
        return .location
    }

    var queries: String {
        switch self {
        case .page(number: let number):
            return "?page=\(number)"
        case .id(_: let id):
            return "/\(id)"
        case .url(_: let url):
            return url
        }
    }

    var httpMethod: HTTPMethodType {
        return .get
    }

}
