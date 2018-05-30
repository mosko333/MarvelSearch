//
//  PoweredPersonModelController.swift
//  MarvelSearch
//
//  Created by Adam on 30/05/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit


class PoweredPersonModelController {
    struct Constants {
        static let baseURL = URL(string: "https://gateway.marvel.com/")
        static let publicKey = "86c7f8a803e9667decddc37f510c853a"
        static let privateKey = "8f3ba9c012c24d233c21939f2886f9c15fd43ff3"
        static let setTimestamp = "1527711881"
        static let setHashKey = "6b51321baae6388e7ba9c0e76d4249e8"
        static let dynamicHashKeyGenerated = "\(Constants.setTimestamp)\(Constants.privateKey)\(Constants.publicKey)".utf8.md5.description
    }
    // https://gateway.marvel.com/v1/public/characters?name=beast&ts=1527711881&apikey=86c7f8a803e9667decddc37f510c853a&hash=6b51321baae6388e7ba9c0e76d4249e8
    
    static func fetchPoweredPersonWith(name: String, completion: @escaping ((PoweredPerson?) -> Void)) {
        // URL
        
        // Request
        
        // URLSessionDataTask + Resume + Decode
    }
}
