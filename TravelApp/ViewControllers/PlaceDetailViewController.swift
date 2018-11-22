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
    
    var moc: NSManagedObjectContext!
    var destination: Destination?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let dest = self.destination{
            placeNameLabel.text = dest.name
            
        }
        // Do any additional setup after loading the view.
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
