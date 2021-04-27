//
//  DetailViewController.swift
//  NasaData
//
//  Created by yacheng on 2021/4/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var nasaData : NasaData?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hdurlImage: UIImageView!
    var spinner = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.hidesWhenStopped = true
        hdurlImage.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([spinner.topAnchor.constraint(equalTo: hdurlImage.centerYAnchor),spinner.centerXAnchor.constraint(equalTo: hdurlImage.centerXAnchor)])
        
        spinner.startAnimating()
        
        tableView.delegate = self
        tableView.dataSource = self
        let newdate = dateformatter(date: nasaData!.date, format: "yyyy MMM. dd")
        dateLabel.text = newdate
        getImage()
        
        
    }
    
    func getImage(){
        
        if let url = URL(string: nasaData!.hdurl){
            let task = URLSession.shared.dataTask(with: url,completionHandler: {
                (data, response, error) in
                
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.spinner.stopAnimating()
                        self.hdurlImage.image = image
                    }
                }
                
            }).resume()
        }
    }
   

}
extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self),for: indexPath) as! DetailTableViewCell
            cell.shortTextLabel.text = nasaData?.title
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTableViewCell.self),for: indexPath) as! DetailTableViewCell
            cell.shortTextLabel.text = nasaData?.copyright
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTextTableViewCell.self),for: indexPath) as! DetailTextTableViewCell
            cell.descriptionLabel.text = nasaData?.description
            
            return cell
        default:
            fatalError()
        }
        
        
    }
    
    func dateformatter(date: String,format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: date){
            
            let outputformatter = DateFormatter()
            outputformatter.dateFormat = format
            
            return outputformatter.string(from: date)
        }
        
        return nil
    }
    
}
