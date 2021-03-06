//
//  MapViewController.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-29.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var destination: Destination!
    var destinations: [Destination]?
    
    @IBOutlet var mapView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let camera = GMSCameraPosition.camera(withLatitude: destination.latitude, longitude: destination.longitude, zoom: 7)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        MapHelper.addMarker(forDestination: destination, onMap: mapView, withColor: nil)
        if let dests = destinations {
            for i in 0...(dests.count - 1)  {
                if dests[i] != destination {
                    MapHelper.addMarker(forDestination: dests[i], onMap: mapView, withColor: UIColor.blue)
                }
            }
            MapHelper.addPath(forDestinations: dests, onMap: mapView)
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
