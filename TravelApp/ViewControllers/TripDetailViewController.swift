//
//  TripDetailViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-10-23.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces

class TripDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let addTripButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
        self.navigationItem.rightBarButtonItem = addTripButton
        // Do any additional setup after loading the view.
    }
    

    @objc func addLocation(){
        //add code to add a trip
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TripDetailViewController: GMSAutocompleteViewControllerDelegate{
    //handle the user's selection.
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
    
}


