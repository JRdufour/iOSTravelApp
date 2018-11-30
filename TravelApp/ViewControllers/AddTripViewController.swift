//
//  AddTripViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-07.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreData

class AddTripViewController: UITableViewController {
    //MARK: Outlets
    @IBOutlet var tripNameTextField: UITextField!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    @IBOutlet var startingPlaceLabel: UILabel!
    
    var moc: NSManagedObjectContext!
    var locationManager: CLLocationManager!
    var tempPlaceId: String?
    var startingPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Trip"
        
        if self.moc != nil{
            print("moc good")
        }
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
        //check that the name text field isnt empty
        if tripNameTextField.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "Name Your Trip", message: "Your trip requires a name to be created.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
            return
        } else if startingPlace == nil{
            let alert = UIAlertController(title: "Add Starting Location", message: "Please add the location you wish to start your trip", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil ))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        //add the new trip to db
        let newTrip = Trip(context: moc)
        newTrip.name = tripNameTextField.text
        newTrip.startDate = startDatePicker.date
        newTrip.endDate = endDatePicker.date
        
        if let location = startingPlace{
        let newDestination = Destination(context: moc)
        newDestination.name = location.name
        newDestination.placeId = location.placeID
        newDestination.latitude = location.coordinate.latitude
        newDestination.longitude = location.coordinate.longitude
        
        newTrip.addToDestinations(newDestination)
        }
        print("adding trip...")
        save()
        
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
        startingPlaceLabel.text = place.name.localizedCapitalized
        startingPlace = place
        dismiss(animated: true, completion: nil)

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)

    }
    
    
    func save(){
        do{
            try moc.save()
        }catch let error {
            print("we have an error saving - \(error)")
            self.moc.rollback()
        }
    }
}
