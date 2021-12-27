//
//  BackendController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import Foundation

class BackendController {

    private let apiURL: URL = URL(string: "https://rickandmortyapi.com/api")!

    func get(completion: @escaping (Any?, Error?) -> Void) {
        var urlRequest = URLRequest(url: apiURL.appendingPathComponent("character/1,2,3,4,20"))
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
                completion(dat, nil)

            } catch let error {
                completion(nil, error)
            }
            return
        }.resume()

    }

    func locationBy(url: String, completion: @escaping (Any?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain:"Passed in String was invalid URL.", code: 0, userInfo: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
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
                let dat = try JSONDecoder().decode(Location.self, from: data)
                print("Decoded location: \(dat)")
                completion(dat, nil)

            } catch let error {
                completion(nil, error)
            }
            return
        }.resume()
    }

    func getImageAt(url: String, completion: @escaping (Any?, Error?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, NSError(domain:"Passed in String was invalid URL.", code: 0, userInfo: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
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

            completion(data, nil)
            return
        }.resume()
    }
}
