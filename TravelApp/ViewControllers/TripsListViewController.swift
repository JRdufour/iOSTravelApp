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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Trips"
        
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

