//
//  AddTripViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-07.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit

class AddTripViewController: UITableViewController {
    //MARK: Outlets
    @IBOutlet var tripNameTextField: UITextField!
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Trip"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddTrip(_ sender: Any) {
    //    print("trip added")
        print("trip added")
        //TODO add trip to the database
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTrip(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
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
