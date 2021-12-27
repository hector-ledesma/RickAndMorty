//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import UIKit

class LocationDetailViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var residentsLabel: UILabel!

    var controller: BackendController?
    {
        didSet {
            fetchLocation()
        }
    }
    var character: Character?
    var location: Location?
    {
        didSet {
            DispatchQueue.main.sync {
                guard let location = location else {
                    fatalError("Huh? How?")
                }

                typeLabel.text = location.type
                dimensionLabel.text = location.dimension
                residentsLabel.text = "\(location.residents.count)"
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func fetchLocation() {
        guard let controller = controller,
              let character = character else {
            fatalError("How is this even executing lol")
        }

        controller.locationBy(url: character.location.url) { (data, error) in
            if let error = error {
                print("Got error in fetching location: \(error)")
            }

            guard let data = data as? Location else {
                print("Error with data")
                return
            }

            print("Received Location: \(data)")
            self.location = data

        }

    }


}
