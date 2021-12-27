//
//  Manager.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/27/21.
//

import Foundation

class Manager {
    private let backendController: BackendController
    private let storageController: StorageController
    var charCount: Int {
        return storageController.charCount()
    }

    private var currentPage: Int = 1

    init(backendController: BackendController = BackendController(), storageController: StorageController = StorageController()) {
        self.backendController = backendController
        self.storageController = storageController
    }

    func getCharacterAt(index: Int) -> Character {
        return storageController.getCharacterAt(index: index)
    }

    func getImageDataFor(character: Character, completion: @escaping (Data?, Error?) -> Void) {
        if let data = storageController.getCachedImage(for: character.id) {
            print("Image data found in cache.")
            completion(data, nil)
        }

        backendController.getImageAt(url: character.image) { [weak self] (data, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data as? Data else {
                completion(nil, NSError(domain: "No data to unwrap", code: 0, userInfo: nil))
                return
            }

            guard let self = self else {
                completion(nil, NSError(domain: "No self", code: 0, userInfo: nil))
                return
            }

            self.storageController.cacheImage(data: data, for: character.id)
            completion(data, nil)
        }

    }

    func fetchLocationFrom(character: Character, completion: @escaping (Location?, Error?) -> Void) {
        if let location = storageController.getLocationBy(name: character.location.name) {
            print("Location was in cache")
            completion(location, nil)
            return
        }

        backendController.locationBy(url: character.location.url) { [weak self](data, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data as? Data else {
                completion(nil, NSError(domain: "No data to unwrap", code: 0, userInfo: nil))
                return
            }

            guard let self = self else {
                completion(nil, NSError(domain: "No self", code: 0, userInfo: nil))
                return
            }

            do {
                let location: Location = try self.storageController.parseLocation(from: data)
                completion(location, nil)
                return
            } catch let error {
                completion(nil, error)
                return
            }
        }


    }

    func fetchNextPage(completion: @escaping (Bool) -> Void) {
        backendController.get { [weak self] (data, error) in
            if let error = error {
                print("Error on page fetch. \(error)")
                completion(false)
                return
            }

            guard let data = data as? Data else {
                print("Error unwrapping data.")
                completion(false)
                return
            }

            guard let self = self else {
                completion(false)
                return
            }

            do {
                try self.storageController.parseCharacters(from: data)
                self.currentPage += 1
                completion(true)
            } catch let error {
                print("Error parsing characters: \(error)")
                completion(false)
            }

        }
    }




}
