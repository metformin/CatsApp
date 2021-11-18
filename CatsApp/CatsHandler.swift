//
//  CatsInteractor.swift
//  CatsApp
//
//  Created by Darek on 13/11/2021.
//

import Foundation

class CatsHandler{
    let apiService: CatsAPIService
    let jsonDecoder: DecodeCat
    
    init(apiService: CatsAPIService, jsonDecoder: DecodeCat){
        self.apiService = apiService
        self.jsonDecoder = jsonDecoder
    }
    
    func handle(completion: @escaping([Cat]?) -> Void){
        apiService.fetchCats {[unowned self] data in
            let cats = try? self.jsonDecoder.decode(json: data)
            completion(cats)
        }
    }
}
