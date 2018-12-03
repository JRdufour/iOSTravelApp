//
//  ViewControllerSwipeDismiss.swift
//  TravelApp
//
//  Created by jonathan Dufour on 2018-12-01.
//  Copyright © 2018 ca.stclairconnect.JonathanDufour. All rights reserved.
//
/**
 This class allows a viewcontroller to be dismissed by dragging it off the screen
 **/
import Foundation
import UIKit
class ViewControllerSwipeDismissable: UIViewController{
    var gestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPosition: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        view.addGestureRecognizer(gestureRecognizer!)
    }
    
    
    @objc func gestureAction(_ panGesture: UIPanGestureRecognizer){
        let translation = panGesture.translation(in: view)
            
        if panGesture.state == .began {
            originalPosition = view.center
            currentPosition = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint( x: translation.x, y: translation.y)
                
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height)
                        
                }, completion: { (complete) in
                    if complete {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                        self.view.center = self.originalPosition!
                })
                
            }
        }
    }
}
