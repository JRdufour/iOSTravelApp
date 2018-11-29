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
import CoreData
class ImageManager{
    
    static func saveImage(imageToSave image: UIImage, forKey key: String, managedObjectContext moc: NSManagedObjectContext){
        //convert image to NSData
        let imageData: NSData = image.pngData()! as NSData
       //save the image
        
    }
    
    static func retrieveImage(forKey key: String) -> UIImage?{
        let data = UserDefaults.standard.object(forKey: key) as! NSData
        return UIImage(data: data as Data)
    }
    
    //function that will tell if a file exists in UserDefaults, if it does, return it, if it doesn't find one from google and save it to user defaults
    
    


    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
             //   self.image = photo
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
