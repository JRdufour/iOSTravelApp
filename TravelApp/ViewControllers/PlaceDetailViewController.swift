//
//  PlaceDetailViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-07.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import CoreData

class PlaceDetailViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var placeNameLabel: UILabel!
    @IBOutlet var placeDatesLabel: UILabel!
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var agendaTableVIew: UITableView!
    @IBOutlet var placeImageInverted: UIImageView!
    
    @IBOutlet var roundedView: UIView!
    @IBOutlet var shadowView: UIView!
    
    
    var moc: NSManagedObjectContext!
    var destination: Destination?
    var agenda: [AgendaItem]!

    let cornerRadius = CGFloat(5.0)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agendaTableVIew.dataSource = self
        if let dest = self.destination{
            placeNameLabel.text = dest.name
            if let items = destination?.agendaItems {
                self.agenda = Array(items) as? [AgendaItem]
            }
           
            if let photo = ImageManager.retrieveImage(forDestination: dest, moc: moc){
                placeImageView.image = photo
                self.placeImageInverted.image = UIImage(cgImage: photo.cgImage!
                    , scale: 1.0, orientation: UIImage.Orientation.downMirrored)
            }
            
            roundedView.clipsToBounds = true
            roundedView.layer.cornerRadius = cornerRadius
            
            shadowView.layer.cornerRadius = cornerRadius
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            shadowView.layer.shadowOpacity = 0.6
            shadowView.layer.shadowRadius = 2.0
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AgendaDetailViewController
        vc.moc = moc
        vc.dest = destination
        if segue.identifier == "agendaDetailSegue"{
            //existing agenda item
            if let selectedIndex = agendaTableVIew.indexPathForSelectedRow{
                vc.agendaItem = agenda![selectedIndex.row]
            }
        }
        
        if segue.identifier == "newAgendaItemSegue"{
            //new agenda item
            vc.agendaItem = nil
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.agendaTableVIew.reloadData()
    }


}

extension PlaceDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(agenda.count)
        return agenda.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = agenda[indexPath.row]
        let cell = agendaTableVIew.dequeueReusableCell(withIdentifier: "agendaCell")
        cell?.textLabel?.text = item.title
        cell?.textLabel?.textColor = UIColor.white
        return cell!
    }
    
    
}


extension PlaceDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //alert asking to confirm delete
            //let cell = tripListTableView.cellForRow(at: indexPath)
            
            //ask to confirm delete
            var deleteMessage = "Are you sure you want to delete this item?"
            let item = agenda[indexPath.row]
            let alert = UIAlertController(title: "Delete Agenda Item", message: deleteMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel , handler: nil ))
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                self.moc.delete(item)
                do{
                    try self.moc.save()
                }catch{
                    
                }
                self.agendaTableVIew.reloadData()
            }))
            self.present(alert, animated: true, completion: nil)
            return
            
            //tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
