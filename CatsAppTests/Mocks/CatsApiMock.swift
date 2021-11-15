//
//  CatsApiServiceMock.swift
//  CatsAppTests
//
//  Created by Darek on 13/11/2021.
//

import Foundation
@testable import CatsApp

class CatsApiMock: CatsAPIService{
    func fetchCats(completion: @escaping (Data) -> Void) {
        let json = "[{\"breeds\":[{\"name\":\"Max\"}],\"id\":\"a2a\",\"url\":\"https://cdn2.thecatapi.com/images/a2a.jpg\",\"width\":430,\"height\":286},{\"breeds\":[],\"id\":\"MTczOTc0Mg\",\"url\":\"https://cdn2.thecatapi.com/images/MTczOTc0Mg.gif\",\"width\":300,\"height\":169}]".data(using: .utf8)
        
        completion(json!)
    }
}
