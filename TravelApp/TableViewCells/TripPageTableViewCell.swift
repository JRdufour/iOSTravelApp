//
//  TripPageTableViewCell.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-11-14.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//

import UIKit
import GooglePlaces

class TripPageTableViewCell: UITableViewCell {
    
    @IBOutlet var TripNameLabel: UILabel!
    @IBOutlet var TripDatesLabel: UILabel!
    @IBOutlet var TripImage: UIImageView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var shadowView: UIView!
    
    let cornerRadius = CGFloat(5.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = self.cornerRadius
        //cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        shadowView.layer.cornerRadius = self.cornerRadius
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        shadowView.layer.shadowOpacity = 0.6
        shadowView.layer.shadowRadius = 2.0
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadFirstPhotoForPlace(placeID: String) {
        
        GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                if let firstPhoto = photos?.results.first {
                    self.saveImageForMetadata(photoMetadata: firstPhoto, forKey: placeID)
                }
            }
        }
    }
    
    func saveImageForMetadata(photoMetadata: GMSPlacePhotoMetadata, forKey key: String) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                ImageManager.saveImage(imageToSave: photo!, forKey: key)
                ImageManager.retrieveImage(forKey: key)
                self.TripImage.image = photo;
                //self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }
}
