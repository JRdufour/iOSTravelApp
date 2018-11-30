//
//  MapHelper.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-29.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
class MapHelper{
    
    static func addMarker(forDestination dest: Destination, onMap map: GMSMapView, withColor color: UIColor?){
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2D(latitude: dest.latitude, longitude: dest.longitude)
        marker.title = dest.name
       // marker.snippet = "Australia"
        if let color = color {
            marker.icon = GMSMarker.markerImage(with: color)
        }
        marker.map = map
    }

    
}
