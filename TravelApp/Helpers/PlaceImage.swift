//
//  PlaceImage.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-28.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class PlaceImage{
    var image: UIImage?
    
    
    
    
    
    func saveImage(imageToSave image: UIImage){
       // let imageData: NSData
    }
    
    
    func fetchPlaceImage(forDestination destination: Destination) {
        if let id = destination.placeId {
            loadFirstPhotoForPlace(placeID: id)
        }
    }
    
    

    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.image = photo
            }
        })
    }

    func loadFirstPhotoForPlace(placeID: String) {
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }
    
}
