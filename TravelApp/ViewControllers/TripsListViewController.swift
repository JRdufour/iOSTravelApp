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
        
        if segue.identifier == "tripDetailSegue"{
            let targetVC =  segue.destination as! TripDetailViewController
           // let targetVC = vc.topViewController as! TripDetailViewController
            targetVC.moc = self.moc
            if let indexPath = tripListTableView.indexPathForSelectedRow{
                targetVC.trip = fetchedResultsController.object(at: indexPath)
                let selectedCell =  tripListTableView.cellForRow(at: indexPath) as! TripPageTableViewCell
                if let image = selectedCell.TripImage.image{
                    targetVC.image = image
                }
            } else { return }
            
            
        }
    }
    
    
}

//MARK: Table view delegate extension
extension TripsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //alert asking to confirm delete
            //let cell = tripListTableView.cellForRow(at: indexPath)
            let trip = fetchedResultsController.object(at: indexPath)
            //ask to confirm delete
            var deleteMessage = "Are you sure you want to delete your trip "
            deleteMessage += trip.name ?? "?"
            let alert = UIAlertController(title: "Delete Trip", message: deleteMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel , handler: nil ))
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                self.moc.delete(trip)
                self.save()
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
           //tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
   
}


extension TripsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripListCell") as! TripPageTableViewCell
        cell.TripImage.image = nil
        let trip = fetchedResultsController.object(at: indexPath)
        
        
        cell.TripNameLabel.text = trip.name?.capitalized
        
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            return formatter
        }()
        if let date = trip.startDate{
            cell.TripDatesLabel.text = dateFormatter.string(from: date)
            
        }
        
        if let destinations = trip.destinations{
            //TODO get the first destination for the trip
            let destinationArray = Array(destinations)
            if let firstDestinaton = destinationArray.first as? Destination{
            let id = firstDestinaton.placeId!
                cell.loadFirstPhotoForPlace(placeID: id)
            }
        }
            
        
      //  cell.loadFirstPhotoForPlace(placeID: )
        return cell
        
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


