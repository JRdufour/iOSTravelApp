//
//  PlaceImage.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-28.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import GooglePlaces

class ImageManager{
    
    static func saveImage(imageToSave image: UIImage, forDestination dest: Destination, managedObjectContext moc: NSManagedObjectContext){
        //convert image to NSData
        let imageData: NSData = image.pngData()! as NSData
       //save the image
        dest.image = imageData as Data
        
        do{
            try moc.save()
        }catch{
            
        }
    }
    static func retrieveImage(forDestination dest: Destination) -> UIImage?{
      
        if let data = dest.image{
            return UIImage(data: data)
        }
     return nil
    }
    
    static func saveFirstPhotoForPlace(destination: Destination, moc: NSManagedObjectContext) {
        
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: destination.placeId!) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.saveImageForMetadata(photoMetadata: firstPhoto, forDestination: destination, moc: moc)
                }
            }
        }
    }
    
    static func saveImageForMetadata(photoMetadata: GMSPlacePhotoMetadata, forDestination dest: Destination, moc: NSManagedObjectContext) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                //self.TripImage.image = photo;
                if let pic = photo {
                    print("SAVING GOOGLE IMAGE")
                    ImageManager.saveImage(imageToSave: pic, forDestination: dest, managedObjectContext: moc)
                }
            }
        })
    }
}
