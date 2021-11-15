//
//  JsonDecoder.swift
//  CatsApp
//
//  Created by Darek on 13/11/2021.
//

import Foundation

struct CatJSON: Codable {
    let breeds: [Breed]
    let url: String
}
struct Breed: Codable {
    let name: String
}
typealias CatsJSON = [CatJSON]

protocol DecodeCat {
    func decode(json: Data) throws -> [Cat]
}

class CatsJsonDecoder: DecodeCat {
    func decode(json: Data) throws -> [Cat] {
        var cats: [Cat] = []
        let jsonDecoder = JSONDecoder()
        do {
            let pardesJSON = try jsonDecoder.decode(CatsJSON.self, from: json)
            for cat in pardesJSON {
                let newCat = Cat(name: cat.breeds.first?.name, pictrue: cat.url)
                cats.append(newCat)
            }
            print("Cats: \(cats)")
            return cats
        } catch (let err){
            throw err
        }
    }
}
