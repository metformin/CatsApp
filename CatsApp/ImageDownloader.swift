//
//  ImageDownloader.swift
//  CatsApp
//
//  Created by Darek on 13/11/2021.
//

import Foundation

class ImageDownloader{
    static let shared = ImageDownloader()
    func fetchImageData(forImage url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
