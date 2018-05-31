//
//  PoweredPerson.swift
//  MarvelSearch
//
//  Created by Adam on 30/05/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

struct FirstLevelData : Codable {
    let data: DataDictionary
    struct DataDictionary: Codable {
        let results : [PoweredPerson]
    }
}

struct PoweredPerson : Codable {
    let name: String
    let description: String
    let thumbnail: ImgPath
}

struct ImgPath : Codable {
    let path: String
    let format: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
}
