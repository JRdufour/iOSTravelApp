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

    @IBOutlet var roundedView: UIView!
    @IBOutlet var tripNameLabel: UILabel!
    @IBOutlet var tripDatesLabel: UILabel!
    @IBOutlet var destinationsTableView: UITableView!
    @IBOutlet var tripImage: UIImageView!
    @IBOutlet var reversedImage: UIImageView!
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var addDestinationButton: UIButton!
    @IBOutlet var editTripButton: UIButton!
    
    
    let cornerRadius = CGFloat(5.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tripNameLabel.text = trip.name?.capitalized
        //TODO set the dates for the trip
        if let allDestinations = trip.destinations{
            self.destinations = Array(allDestinations) as? [Destination]
        } else{
            self.destinations = []
        }
        self.destinationsTableView.dataSource = self
        
        if let image = image{
            self.tripImage.image = image
            self.reversedImage.image = UIImage(cgImage: image.cgImage!
                , scale: 1.0, orientation: UIImage.Orientation.downMirrored)
        }
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            return formatter
        }()
        
        if let startDate = trip.startDate,  let endDate = trip.endDate {
            tripDatesLabel.text = dateFormatter.string(from: startDate) + " - " + dateFormatter.string(from: endDate)
        }
        
        
        //table view styling
        roundedView.clipsToBounds = true
        roundedView.layer.cornerRadius = cornerRadius
        addDestinationButton.layer.cornerRadius = cornerRadius
        editTripButton.layer.cornerRadius = cornerRadius
        
        shadowView.layer.cornerRadius = cornerRadius
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowRadius = 2.0
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "placeDetailSegue"{
            let vc = segue.destination as! UITabBarController
            let targetVC = vc.viewControllers![0] as! PlaceDetailViewController
            let mapVC = vc.viewControllers![1] as! MapViewController
           
            targetVC.moc = self.moc
            if let indexPath = destinationsTableView.indexPathForSelectedRow{
                    let targetDestination = destinations[indexPath.row]
                    targetVC.destination = targetDestination
                    mapVC.destination = targetDestination
                    targetVC.moc = self.moc
                }
            } else { return }
        
        
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
       // print(trip.destinations?.count)
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
       
        let newDest = Destination(context: moc)
        newDest.placeId = place.placeID
        newDest.name = place.name
        newDest.longitude = place.coordinate.longitude
        newDest.latitude = place.coordinate.latitude
        newDest.trip = trip
        
        self.trip.destinations?.adding(newDest)
        save()
        //TODO
        destinations.append(newDest)
        destinationsTableView.reloadData()
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


