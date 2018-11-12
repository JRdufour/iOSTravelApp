//
//  AddTripViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-07.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces

class AddTripViewController: UITableViewController {
    //MARK: Outlets
    @IBOutlet var tripNameTextField: UITextField!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    var locationManager: CLLocationManager!
    @IBOutlet var startingPlaceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Trip"
        
        
        // Do any additional setup after loading the view.
//        let placesClient = GMSPlacesClient.shared()
//        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
//            if let error = error {
//                print("Pick Place error: \(error.localizedDescription)")
//                return
//            }
//
//            if let placeLikelihoodList = placeLikelihoodList {
//                for likelihood in placeLikelihoodList.likelihoods {
//                    let place = likelihood.place
//                    print("Current Place name \(place.name) at likelihood \(likelihood.likelihood)")
//                    print("Current Place address \(place.formattedAddress)")
//                    print("Current Place attributions \(place.attributions)")
//                    print("Current PlaceID \(place.placeID)")
//                }
//            }
//        })
        
        
    }
    
    
    
    @IBAction func AddTrip(_ sender: Any) {
    //    print("trip added")
        print("trip added")
        //TODO add trip to the database
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTrip(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 1{
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            present(autocompleteController, animated: true, completion: nil)

        }
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

extension AddTripViewController: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        startingPlaceLabel.text = place.name
        dismiss(animated: true, completion: nil)

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)

    }
    

    
    

}
