//
//  ViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-10-23.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreData
class TripsListViewController: UIViewController {
    var moc: NSManagedObjectContext!

    @IBOutlet var tripListTableView: UITableView!
    var fetchedResultsController: NSFetchedResultsController<Trip>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Trips"
        
        self.tripListTableView.delegate = self
        self.tripListTableView.dataSource = self
       // self.tripListTableView.prefetchDataSource = self
        
        //fetch request for fetchedResults controller
        let fetchRequest = NSFetchRequest<Trip>(entityName: "Trip")
        fetchRequest.sortDescriptors = []
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        do{
            try fetchedResultsController.performFetch()
        } catch let error {
            print("Problem fetching results - \(error)")
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewTripSegue"{
            let vc = segue.destination as! UINavigationController
            let targetVc = vc.topViewController as! AddTripViewController
            targetVc.moc = self.moc
            
            
        }
    }
}

//MARK: Table view delegate extension
extension TripsListViewController: UITableViewDelegate {
    
}


extension TripsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripListCell") as! TripPageTableViewCell
        
        let trip = fetchedResultsController.object(at: indexPath)
        
        cell.TripNameLabel.text = trip.name
        cell.TripDatesLabel.text = trip.startDate?.description
        
        if let destinations = trip.destinations{
            //TODO get the first destination for the trip
            
        }
            
        
      //  cell.loadFirstPhotoForPlace(placeID: )
        return cell
        
    }
    
       
    
}



//Fetched results controller extension

extension TripsListViewController: NSFetchedResultsControllerDelegate{
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tripListTableView.endUpdates()
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tripListTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            guard let deleteIndexPath = indexPath else { return }
            tripListTableView.deleteRows(at: [deleteIndexPath], with: .automatic)
        case .insert:
            guard let insertPath = newIndexPath else { return }
            tripListTableView.insertRows(at: [insertPath], with: .automatic)
        case .move:
            guard let newPath = newIndexPath, let oldPath = indexPath else { return }
            tripListTableView.moveRow(at: oldPath, to: newPath)
        case .update:
            guard let existingPath = indexPath else { return }
            tripListTableView.reloadRows(at: [existingPath], with: .automatic)
        }
    }
}


