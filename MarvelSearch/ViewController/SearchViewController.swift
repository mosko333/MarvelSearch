//
//  SearchViewController.swift
//  MarvelSearch
//
//  Created by Adam on 30/05/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    var poweredPerson: PoweredPerson?
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.poweredPerson = nil
        self.profileImage = nil
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        guard !searchTextField.text!.isEmpty, let name = searchTextField.text else { return }
        PoweredPersonModelController.fetchPoweredPersonWith(name: name) { (person) in
            if let person = person {
                self.poweredPerson = person
                PoweredPersonModelController.fetchImageWith(person: person, completion: { (image) in
                    self.profileImage = image
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "searchSegue", sender: nil)
                    }
                })
            } else {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "searchSegue", sender: nil)
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.poweredPerson = self.poweredPerson
            destinationVC.poweredPersonImage = self.profileImage
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.resignFirstResponder()
    }
}
