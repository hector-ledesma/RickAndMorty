//
//  BackendController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import Foundation

struct BackendController {
    private let apiURL: URL = URL(string: "https://rickandmortyapi.com/api")!
    

    func get(completion: @escaping (Any?, Error?) -> Void) {
        var urlRequest = URLRequest(url: apiURL.appendingPathComponent("character/1,20"))
        urlRequest.httpMethod = "GET"

        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let _ = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: 0, userInfo: nil))
                return
            }

            do {
                let dat = try JSONDecoder().decode([Character].self, from: data)
                print("Decoded character: \(dat)")


            } catch let error {
                completion(nil, error)
            }


            return
        }.resume()

    }
}
