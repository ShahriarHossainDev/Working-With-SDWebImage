//
//  ViewController.swift
//  Working With SDWebImage
//
//  Created by Shishir_Mac on 13/2/24.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var dogAllData: DogData?
    var dogImageLinks = [String]()
    
    @IBOutlet weak var dogsUICollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Dogs"
        
        dogsUICollectionView.delegate = self
        dogsUICollectionView.dataSource = self
        
        self.dogsUICollectionView.register(UINib(nibName: "DogCollectionViewCell", bundle: nil),
                                           forCellWithReuseIdentifier: "DogCollectionViewCell")
        
        fatchData()
    }
    
    func fatchData() {
        let url = URL(string: "https://dog.ceo/api/breed/hound/images")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print("Error Data")
                return
            }
            
            var dogObject: DogData?
            
            do {
                dogObject = try JSONDecoder().decode(DogData.self, from: data)
            } catch {
                print(error)
            }
            
            self.dogAllData = dogObject
            self.dogImageLinks = self.dogAllData!.message
            
            DispatchQueue.main.async {
                self.dogsUICollectionView.reloadData()
            }
            
        }
        task.resume()
    }
    
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogImageLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCollectionViewCell", for: indexPath) as! DogCollectionViewCell
        
        if let imageURL = URL(string: dogImageLinks[indexPath.row]) {
            cell.photoImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.photoImageView.sd_imageIndicator?.startAnimatingIndicator()
            cell.photoImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "empty"),
                                            options: .continueInBackground, completed: nil)
        } else {
            cell.photoImageView.image = UIImage(named: "empty")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 10) / 2
        return CGSize(width: size, height: size)
    }
    
}

