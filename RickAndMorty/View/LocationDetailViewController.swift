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


    var delegate: DetailViewDelegate? {
        didSet {
            fetchLocation()
        }
    }

    var location: Location? {
        didSet {
            updateLocation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocation()
    }

    private func fetchLocation() {
        guard let delegate = self.delegate else {
            fatalError("How executed?")
        }

        delegate.locationFor(view: self)
        
    }

    private func fetchImage() {
    }

    private func updateImage(data: Data) {
        DispatchQueue.main.async {
            self.characterImage.image = UIImage(data: data)
        }
    }

    private func updateLocation() {
        DispatchQueue.main.async {
            if !self.isViewLoaded {return}
            guard let location = self.location else {return}
            self.typeLabel.text = location.type
            self.dimensionLabel.text = location.dimension
            self.residentsLabel.text = "\(location.residents.count)"
        }
    }


}
