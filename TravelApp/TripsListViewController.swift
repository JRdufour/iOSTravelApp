//
//  ViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-10-23.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit

class TripsListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Trips"
        let addTripButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTrip))
        self.navigationItem.rightBarButtonItem = addTripButton
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func addTrip(){
        //add code to add a trip
        
    }

}



