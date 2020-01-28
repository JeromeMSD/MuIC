//
//  Music.swift
//  MuIC
//
//  Created by Jerome Massard on 15/01/2020.
//  Copyright © 2020 Jerome Massard. All rights reserved.
//
import MediaPlayer

class Music {
    var title: String = "Unknow title"
    var artiste: String = "Unknow artist"
    var duration: (min: Int, sec: Int) = (00,00)
    var path: String = ""
    
    init(path: String){
        self.path = path
        
        // Load DATA From file
    }
    
    init(title: String, art: String, duration: (min: Int, sec: Int)){
        self.title = title
        self.artiste = art
        self.duration = duration
    }
    
    func loadFileInfo(){
        
    }
    
    func getDurationSring() -> String {
        return String(duration.min) + ":" + String(duration.sec)
    }
    
    class func convertDoubletoDurationTuple(durationToConvert: Float) -> (min: Int, sec: Int) {
        let min = Int(floor(durationToConvert))
        let sec = Int((durationToConvert - Float(min)) * 60)
        return (min, sec)
    }
    
    class func convertStringtoDuration(durationToConvert: String) -> (min: Int, sec: Int) {
        let floatOfString = Float(durationToConvert)
        let min = Int(floor(floatOfString!))
        let sec = Int((floatOfString! - Float(min)) * 60)
        return (min, sec)
    }
}
