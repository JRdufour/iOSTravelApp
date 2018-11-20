//
//  TripDetailViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-10-23.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreData

class TripDetailViewController: UIViewController {
    
    var trip: Trip!
    var moc: NSManagedObjectContext!
    var destinations: [Destination]!
    var image: UIImage?

    @IBOutlet var tripNameLabel: UILabel!
    @IBOutlet var tripDatesLabel: UILabel!
    @IBOutlet var destinationsTableView: UITableView!
    @IBOutlet var tripImage: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripNameLabel.text = trip.name?.capitalized
        //TODO set the dates for the trip
        if let allDestinations = trip.destinations{
            self.destinations = Array(allDestinations) as! [Destination]
        } else{
            self.destinations = []
        }
        self.destinationsTableView.dataSource = self
        
        if let image = image{
            self.tripImage.image = image
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

    //MARK: actions
    @IBAction func addDestination(_ sender: Any) {
        //TODO
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)

    }
}

extension TripDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(trip.destinations?.count)
        return self.destinations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripDetailCell")!
        cell.textLabel?.text = self.destinations[indexPath.row].name
        
        return cell
    }
    
    
}

extension TripDetailViewController: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       
        self.trip.destinations?.adding(place)
        
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
