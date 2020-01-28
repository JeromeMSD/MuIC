//
//  MusicTableViewCell.swift
//  MuIC
//
//  Created by Jerome Massard on 10/01/2020.
//  Copyright © 2020 Jerome Massard. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var cellMusicTitle: UILabel!
    @IBOutlet weak var cellMusicArt: UILabel!
    @IBOutlet weak var cellMusicDur: UILabel!
    @IBOutlet weak var cellMusicPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
