//
//  ViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-10-23.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces

class TripsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Trips"
        let addLocationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrip))
        self.navigationItem.rightBarButtonItem = addLocationButton
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func addTrip(){
        //add code to add a trip
        self.performSegue(withIdentifier: "tripDetailSegue", sender: self)
    }

}

