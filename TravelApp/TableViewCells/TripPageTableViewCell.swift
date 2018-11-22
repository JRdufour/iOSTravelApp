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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

       // cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20.0
        //cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.6
        cardView.layer.shadowRadius = 2.0
        
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
                    self.loadImageForMetadata(photoMetadata: firstPhoto)
                }
            }
        }
    }
    
    func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
        GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: {
            (photo, error) -> Void in
            if let error = error {
                // TODO: handle the error.
                print("Error: \(error.localizedDescription)")
            } else {
                self.TripImage.image = photo;
                //self.attributionTextView.attributedText = photoMetadata.attributions;
            }
        })
    }
}
