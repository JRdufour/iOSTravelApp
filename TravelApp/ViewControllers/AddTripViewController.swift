//
//  AddTripViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-07.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add a trip"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddTrip(_ sender: Any) {
    //    print("trip added")
        print("trip added")
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
