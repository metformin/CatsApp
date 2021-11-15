//
//  CatsFetcher.swift
//  CatsApp
//
//  Created by Darek on 12/11/2021.
//

import Foundation

protocol CatsAPIService {
    func fetchCats(completion: @escaping(Data) -> Void)
}

class CatsApi: CatsAPIService {
    func fetchCats(completion: @escaping (Data) -> Void) {
        if let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=5"){
            URLSession.shared.dataTask(with: url) { data, response, err in
                if let err = err  {
                    print(err)
                    return
                }
                if let data = data {
                    completion(data)
                }
            }.resume()
        }
    }
}
