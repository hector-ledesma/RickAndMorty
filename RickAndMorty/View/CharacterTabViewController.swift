//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Karen Rodriguez on 12/26/21.
//

import UIKit

class CharacterTabViewController: UIViewController {


//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    private let manager: LogicManager = Manager()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        collectionView!.collectionViewLayout = layout

        manager.fetchNextPage { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CharacterDetailView" {
            guard let detailVC = segue.destination as? CharacterDetailViewController else {
                fatalError("Couldn't cast destination to view controller class.")
            }

            detailVC.delegate = self

        }
    }

}

// MARK: - CollectionView Protocols
extension CharacterTabViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.charCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // TODO: - Replace fatal error with error handling
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCharCell", for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Checkthis")
        }

        // Cell data
        let char = manager.getCharacterAt(index: indexPath.row)
        cell.statusLabel.text = char.status.rawValue
        cell.nameLabel.text = char.name
        cell.episodesLabel.text = "\(char.episode.count) episodes"
        cell.locationLabel.text = char.location.name

        // Cell styling
        switch char.status {
        case .Alive:
            cell.layer.backgroundColor = UIColor(red: 183/255, green: 247/255, blue: 223/255, alpha: 1.0).cgColor
        case .Dead:
            cell.layer.backgroundColor = UIColor(red: 255/255, green: 188/255, blue: 188/255, alpha: 1.0).cgColor
        case .unknown:
            cell.layer.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0).cgColor
        }
        cell.layer.cornerRadius = 5.0
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false

        // Fetch image
        manager.getImageDataFor(character: char) { (data, error) in
            if let error = error {
                print("Got error fetching image for cell: \(error)")
                return
            }
            guard let data = data else {
                print("Couldn't unwrap image data in cell closure.")
                return
            }
            DispatchQueue.main.async {
                cell.imageView?.layer.cornerRadius = cell.imageView.frame.height/2
                cell.imageView?.image = UIImage(data: data)
            }

        }


        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let width = (screenSize.width-60)/2
        return CGSize(width: width, height: width*1.5)
    }




}

// MARK: - DetailViewDelegate

protocol DetailViewDelegate {
    func locationFor(view detailVC: CharacterDetailViewController?)
    func imageFor(view detailVC: CharacterDetailViewController?)
}

extension CharacterTabViewController: DetailViewDelegate {

    func locationFor(view detailVC: CharacterDetailViewController?) {
        weak var vc = detailVC
        guard let ip = collectionView.indexPathsForSelectedItems else {
            print("No indexpath to be grabbed.")
            return
        }

        let char = manager.getCharacterAt(index: ip[0].row)
        print("Fetching location for: \(char.id) | \(char.name)")

        manager.fetchLocationFor(character: char) { (location, error) in
            if let error = error {
                print("Fetching location failed with error: \(error)")
                return
            }

            guard let location = location else {
                print("Location data couldn't be unwrapped")
                return
            }

            guard let vc = vc else {
                print("Detail View Controller no longer available.")
                return
            }

//            vc.location = location

        }

    }

    func imageFor(view detailVC: CharacterDetailViewController?) {
        weak var vc = detailVC
        guard let ip = collectionView.indexPathsForSelectedItems else { fatalError("No indexpath to be grabbed?") }

        let char = manager.getCharacterAt(index: ip[0].row)
        print("Fetching image for: \(char.id) | \(char.name)")

        manager.getImageDataFor(character: char) { (data, error) in
            if let error = error {
                print("Fetching image data failed withe rror: \(error)")
                return
            }

            guard let data = data else {
                print("Image data couldn't be unwrapped")
                return
            }

            guard let vc = vc else {
                print("Detail View Controller no longer available.")
                return
            }

//            vc.imageData = data
        }

        
    }

}
