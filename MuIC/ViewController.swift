//
//  ViewController.swift
//  MuIC
//
//  Created by Jerome Massard on 10/01/2020.
//  Copyright © 2020 Jerome Massard. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UITableViewDataSource {
    var musics = [Music]()
    
    @IBOutlet weak var playlist: UITableView!
    let musicCell = "musicCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        loadContent()
        playlist.dataSource = self
        
    }
   
    
    // Transfert information from TableView to Detail view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "musicDetails"{
            let detailsMusicVC = segue.destination as! DetailsViewController
            
            let myIndexPath = self.playlist.indexPathForSelectedRow!
            let row = myIndexPath.row
            
            detailsMusicVC.musicTitle = musics[row].title
            detailsMusicVC.musicArtiste = musics[row].artiste
            detailsMusicVC.musicDuration = musics[row].getDurationSring()
            
            // Transfert musics to gesture
            detailsMusicVC.musics = musics
        }
    }
    
    // Returns the number of cells = the number of musics in the playlist
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
       
    // Returns a cell with all the information to be displayed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Find a reusable cell of the appropriate type.
           
        let cell = tableView.dequeueReusableCell(withIdentifier: musicCell, for: indexPath) as! MusicTableViewCell
        let row = indexPath.row
        // Attach param to the cell
        cell.cellMusicTitle.text = musics[row].title
        cell.cellMusicArt.text = musics[row].artiste
        cell.cellMusicDur.text = musics[row].getDurationSring()
        
        return cell
    }
    
    /// FOR TEST / / /
    func loadContent(){
        musics.append(Music(title: "Black Ice", art: "AC/DC", duration: (min: 3, sec: 24)))
        musics.append(Music(title: "Thunder", art: "Imagine Dragons", duration: (min: 3, sec: 33)))
        musics.append(Music(title: "Toss a coin to your Witcher", art: "Jackier", duration: (min: 2, sec: 13)))
        musics.append(Music(title: "Bicycle", art: "Queen", duration: (min: 3, sec: 16)))
        musics.append(Music(title: "Nightcall", art: "Kavinsky, Lovefoxxx", duration: (min: 2, sec: 13)))
        musics.append(Music(title: "Paris", art: "Sofiane Pamart", duration: (min: 2, sec: 13)))
    }

}
