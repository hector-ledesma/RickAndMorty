//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import UIKit

class LocationDetailViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var residentsLabel: UILabel!


    var delegate: DetailViewDelegate? {
        didSet {
            fetchLocation()
            fetchImage()
        }
    }

    var location: Location? {
        didSet {
            updateLocation()
        }
    }

    var imageData: Data? {
        didSet {
            updateImage()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func fetchLocation() {
        guard let delegate = self.delegate else {
            print("No delegate found")
            return
        }

        delegate.locationFor(view: self)
        
    }

    private func fetchImage() {
        guard let delegate = delegate else {
            print("No delegate found")
            return
        }
        
        delegate.imageFor(view: self)
    }

    private func updateImage() {
        DispatchQueue.main.async {
            guard let data = self.imageData else {
                print("No image data could be found.")
                return
            }
            self.characterImage.image = UIImage(data: data)
        }
    }

    private func updateLocation() {
        DispatchQueue.main.async {
            if !self.isViewLoaded {return}
            guard let location = self.location else {return}
            self.locationNameLabel.text = location.name
            self.typeLabel.text = location.type
            self.dimensionLabel.text = location.dimension
            self.residentsLabel.text = "\(location.residents.count)"
        }
    }


}
