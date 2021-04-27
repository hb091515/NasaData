//
//  NasaDataCollectionViewController.swift
//  NasaData
//
//  Created by yacheng on 2021/4/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class NasaDataCollectionViewController: UICollectionViewController {
    
    private var nasaDatas : [NasaData] = []
    private let apiAddress = "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json"
    var urlSession = URLSession(configuration: .default)
    var spinner = UIActivityIndicatorView()
    let imageCache = NSCache<NSURL, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 150.0),spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        spinner.startAnimating()
        configureCellSize()
        //downloadData(webAddress: apiAddress)
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCellSize()

    }

    

    func fetchData() {
        NetworkController.shared.fetchTopMovies {[weak self] (nasaDatas) in
            guard let self = self else { return }
            if let nasaDatas = nasaDatas {
                self.nasaDatas = nasaDatas
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nasaDatas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NasaDataCollectionViewCell
        
        let nasaData = nasaDatas[indexPath.row]
        cell.update(with: nasaData)
        
        return cell
    }
    
    func configureCellSize(){
        let itemSpace: CGFloat = 2
        let columnCount: CGFloat = 4
        
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        
        let width = floor((collectionView.bounds.width - itemSpace * (columnCount - 1)) / columnCount)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
    }
    
    func popAlert(withTitle title:String){
        let Alert = UIAlertController(title: title, message: "請稍後再試", preferredStyle: .alert)
        Alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(Alert, animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let destinationController = segue.destination as! DetailViewController
                destinationController.nasaData = nasaDatas[indexPaths[0].row]
            }
        }
    }
    

}

