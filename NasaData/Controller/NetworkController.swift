//
//  NetworkController.swift
//  NasaData
//
//  Created by yacheng on 2021/4/27.
//

import UIKit

class NetworkController {
    static let shared = NetworkController()
    
    let imageCache = NSCache<NSURL, UIImage>()
    
    func fetchImage(url: URL, completionHandler: @escaping (UIImage?) -> ()) {
        if let image = imageCache.object(forKey: url as NSURL) {
            completionHandler(image)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: url as NSURL)
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        }.resume()
    }
    
    
    
    func fetchTopMovies(completionHandler: @escaping ([NasaData]?) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json") else {
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data, let nasaData = try? decoder.decode([NasaData].self, from: data) {
                completionHandler(nasaData)
            } else {
                completionHandler(nil)
            }
        }.resume()
        
    }
}

