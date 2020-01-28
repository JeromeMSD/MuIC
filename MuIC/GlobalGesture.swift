//
//  GlobalGesture.swift
//  MuIC
//
//  Created by Jerome Massard on 23/01/2020.
//  Copyright © 2020 Jerome Massard. All rights reserved.
//

import UIKit
import MediaPlayer

class GlobalGesture {
    
    @objc class func handlePinch(_ sender : UIPinchGestureRecognizer){
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
            
        }
    
        let volumeView = MPVolumeView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        volumeView.isHidden = false
        volumeView.alpha = 0.25
        
        sender.view!.addSubview(volumeView)
    }
    
    @objc class func handleLongPress(_ sender : UILongPressGestureRecognizer){
        print("coucou")
        
        sender.view!.backgroundColor = .clear
        let volumeView = MPVolumeView(frame: sender.view!.bounds)
        sender.view!.addSubview(volumeView)
    }
    
    @objc class func handleSwipeL(_ sender : UISwipeGestureRecognizer){
        if (sender.direction == .left) {
            print("Swipe Left")
            
        }
    }
    @objc class func handleSwipeR(_ sender : UISwipeGestureRecognizer){
        if (sender.direction == .right) {
            print("Swipe Right")
        }
    }
}
