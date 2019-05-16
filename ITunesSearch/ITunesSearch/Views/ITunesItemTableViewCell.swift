//
//  ITunesItemTableViewCell.swift
//  ITunesSearch
//
//  Created by William Moody on 5/16/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

class ITunesItemTableViewCell: UITableViewCell {

    var iTunesResult: ITunesResults? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    

    func updateViews(){
        guard let itunesResult = iTunesResult else {return}
        self.trackLabel.text = itunesResult.track
        self.artistLabel.text = itunesResult.artist
        self.albumLabel.text = itunesResult.album
    }
}
