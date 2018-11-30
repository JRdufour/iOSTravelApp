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
    
}
