//
//  DetailViewController.swift
//  MuIC
//
//  Created by Jerome Massard on 10/01/2020.
//  Copyright © 2020 Jerome Massard. All rights reserved.
//

import UIKit
import AVFoundation

class DetailsViewController: UIViewController {

    @IBOutlet weak var repeatBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var bgAlbumImageDV: UIImageView!
    @IBOutlet weak var musicPicDV: UIImageView!
    @IBOutlet weak var musicArtDV: UILabel!
    @IBOutlet weak var musicDurDV: UILabel!
    @IBOutlet weak var musicTitleDV: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var currDur: UILabel!
    
    var musicPlayer = AVAudioPlayer()
    
    var musicTitle: String?
    var musicArtiste: String?
    var musicDuration: String?

    var musics: [Music]?
    var currIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // init view
        playButton.setImage(UIImage(named: "pause.png"), for: .normal)
        playButton.tintColor = .white
        
        nextBtn.setImage(UIImage(named: "next.png"), for: .normal)
        nextBtn.tintColor = .white
        
        previousBtn.setImage(UIImage(named: "back.png"), for: .normal)
        previousBtn.tintColor = .white
        
        repeatBtn.setImage(UIImage(named: "repeat.png"), for: .normal)
        repeatBtn.tintColor = .white
        
        // init Field
        if musicTitle != nil { musicTitleDV.text = musicTitle }
        if musicArtiste != nil { musicArtDV.text = musicArtiste }
        if musicDuration != nil { musicDurDV.text = musicDuration }
        currDur.text = "0:00"
        
        
        if (musics != nil) && (musicTitle != nil) && (musicArtiste
         != nil){
            for m in self.musics! {
                if ( m.title == musicTitle ) && ( m.artiste == musicArtiste ) {
                    break
                }
                currIndex = currIndex + 1
            }
        }
        
        // init background
        if let filePath = Bundle.main.path(forResource: "tn.jpg", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            musicPicDV.contentMode = .scaleAspectFit
            musicPicDV.image = image
        }
        bgAlbumImageDV.addSubview(UIVisualEffectView(effect: UIBlurEffect(style: .light)))
        
        // Gesture control
        view.isUserInteractionEnabled = true
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        let swipeR = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeR))
        let swipeL = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeL))
        swipeL.direction = .left
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
            
        view.addGestureRecognizer(pinch)
        view.addGestureRecognizer(swipeR)
        view.addGestureRecognizer(swipeL)
        view.addGestureRecognizer(longPress)
        view.addGestureRecognizer(doubleTap)
        
        // play selected song
        // setSongAndPlay()
    }
    
    @IBAction func onSliderChange(_ sender: Any) {
        self.musicPlayer.volume = volumeSlider.value
    }
    
    @IBAction func previous(_ sender: Any) { previousFunction() }
    @IBAction func next(_ sender: Any) { nextFunction()  }
    @IBAction func pause(_ sender: Any) { pauseFunction()   }
    @IBAction func repeatP(_ sender: Any) { repeatFunction() }
    
    /// GESTURES FUNCTION
    
    func showToast(message: String, seconds: Double ){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.tintColor = UIColor.white
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
        
    }
    
    // Pause or play current song
    func pauseFunction(){
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            playButton.setImage(UIImage(named: "pause.png"), for: .normal)
        }else{
            musicPlayer.play()
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
        }
    }
    
    // Load the next song in the playlist
    @objc func nextFunction(){
        if (musics!.count > (currIndex + 1)) {

            showToast(message: "next song in your playlist", seconds: 0.75)
            
            let m:Music = musics![currIndex+1]
            musicTitleDV.text = m.title
            musicArtDV.text = m.artiste
            musicDurDV.text = m.getDurationSring()
            
            currIndex = currIndex + 1
        }
        
        //setSongAndPlay()
    }
    
    // Load the previous song in the playlist
    func previousFunction(){
        if ((currIndex - 1) >= 0) {

            showToast(message: "previous song in your playlist", seconds: 0.75)
            
            let m:Music = musics![currIndex - 1]
            musicTitleDV.text = m.title
            musicArtDV.text = m.artiste
            musicDurDV.text = m.getDurationSring()
            
            currIndex = currIndex - 1
        }
        
        //setSongAndPlay()
    }
    
    // Repeat cuurent song
    func repeatFunction(){
        showToast(message: "Repeat", seconds: 0.5)
        musicPlayer.pause()
        musicPlayer.currentTime = 0
        currDur.text = "0:00"
        musicPlayer.play()
    }
    
    /// -----------------
    /// GESTURES FUNCTION
    /// -----------------
    
    @objc func handlePinch(_ sender : UIPinchGestureRecognizer){
        print("Gesture handled - Long Press")
        guard sender.view != nil else { return }
        if sender.state == .began || sender.state == .changed {
            self.musicPlayer.prepareToPlay()
            
            self.musicPlayer.volume = self.musicPlayer.volume * Float(sender.scale)
            self.volumeSlider.value = self.volumeSlider.value * Float(sender.scale)
        }
    }
    
    @objc func handleLongPress(_ sender : UILongPressGestureRecognizer){
        print("Gesture handled - Long Press")
        repeatFunction()
    }
    
    @objc func handleDoubleTap(_ sender : UILongPressGestureRecognizer){
        print("Gesture handled - Double Tap")
        pauseFunction()
    }
    
    @objc func handleSwipeL(_ sender : UISwipeGestureRecognizer){
        if (sender.direction == .left) {
            print("Gesture handled - Swipe Left")
            nextFunction()
        }
    }
    @objc func handleSwipeR(_ sender : UISwipeGestureRecognizer){
        if (sender.direction == .right) {
            print("Gesture handled - Swipe Right")
            previousFunction()
        }
    }
    
    // Prepare and play current song
    func setSongAndPlay(){
        do {
            try musicPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: String(musics![currIndex].path.split(separator: ".")[0])) as URL)
        } catch {
            print ("Error - Can't read file ")
        }
        musicPlayer.prepareToPlay()
        musicPlayer.play()
        musicPlayer.volume = 0.5
    }
    
}
