//
//  DetailViewController.swift
//  MarvelSearch
//
//  Created by Adam on 30/05/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var poweredPerson: PoweredPerson?
    var poweredPersonImage: UIImage?
    var searchTerm: String?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var discriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    func updateView() {
        if let poweredPerson = self.poweredPerson {
            self.nameLabel.text = poweredPerson.name
            self.discriptionLabel.text = poweredPerson.description
            self.profileImage.image = poweredPersonImage
        } else {
            guard let name = searchTerm else { return }
            PoweredPersonModelController.fetchPoweredPersonWith(name: name) { (person) in
                guard let person = person else { return }
                DispatchQueue.main.async {
                    self.nameLabel.text = person.name
                    self.discriptionLabel.text = person.description
                }
                PoweredPersonModelController.fetchImageWith(person: person, completion: { (image) in
                    DispatchQueue.main.async {
                        self.profileImage.image = image
                    }
                })
            }
        }
    }
}
