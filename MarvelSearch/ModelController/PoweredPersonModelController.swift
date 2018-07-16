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
        static let setHashKeyGenerated = "\(Constants.setTimestamp)\(Constants.privateKey)\(Constants.publicKey)".utf8.md5.description
    }
    // https://gateway.marvel.com/v1/public/characters?name=beast&ts=1527711881&apikey=86c7f8a803e9667decddc37f510c853a&hash=6b51321baae6388e7ba9c0e76d4249e8

    static func fetchPoweredPersonWith(name: String, completion: @escaping ((PoweredPerson?) -> Void)) {
        // URL
        guard var url = Constants.baseURL else { completion(nil) ; return }
        url.appendPathComponent("v1")
        url.appendPathComponent("public")
        url.appendPathComponent("characters")

        //Query
        let timeStamp = Date().timeIntervalSince1970

        let urlParamaters = ["name": name,
                            "ts": timeStamp.description,
                            "apikey": Constants.publicKey,
                            "hash": "\(timeStamp)\(Constants.privateKey)\(Constants.publicKey)".utf8.md5.description]

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let queryItems = urlParamaters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        components?.queryItems = queryItems
        guard let completeURL = components?.url else {
            print("Error creating complete url")
            completion(nil)
            return
        }
        print("📡\(completeURL.absoluteString)📡")
        // Request
        // Not needed

        // URLSessionDataTask + Resume + Decode
        URLSession.shared.dataTask(with: completeURL) { (data, _, error) in
            if let error = error {
                print("❌Error downloading PoweredPerson with DataTask: \(error.localizedDescription)")
                completion(nil) ; return
            }
            guard let data = data else { completion(nil) ; return }
            let jsonDecoder = JSONDecoder()
            do {
                let firstLevelData = try jsonDecoder.decode(FirstLevelData.self, from: data)
                guard let poweredPerson = firstLevelData.data.results.first else { completion(nil) ; return }
                completion(poweredPerson) ; return
            } catch DecodingError.keyNotFound(let codingKey, let context) {
                print("❌Error: Coding key not found: \(codingKey) in \(context)")
                completion(nil) ; return
            } catch {
                print("Error decoding fetched PoweredPerson: \(error.localizedDescription)")
                completion(nil) ; return
            }
        }.resume()
    }

    static func fetchImageWith(person: PoweredPerson, completion: @escaping ((UIImage) -> Void) ) {
        // URL
        //http://i.annihil.us/u/prod/marvel/i/mg/2/80/511a79a0451a3/portrait_xlarge.jpg
        guard var url = URL(string: person.thumbnail.path) else { completion(#imageLiteral(resourceName: "noImage")) ; return }
        url.appendPathComponent("portrait_fantastic")
        url.appendPathExtension(person.thumbnail.format)
        print("📡\(url.absoluteString)📡")

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("❌ Error downloading image with DataTask: \(error.localizedDescription)")
                completion(#imageLiteral(resourceName: "noImage")) ; return
            }
            guard let data = data, let image = UIImage(data: data) else { completion(#imageLiteral(resourceName: "noImage")) ; return }
            completion(image)
        }.resume()
    }
}
