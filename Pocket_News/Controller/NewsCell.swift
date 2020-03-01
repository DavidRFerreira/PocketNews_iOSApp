//
//  news.swift
//  Pocket_News
//
//  Created by macOSHighSierra on 29/02/2020.
//  Copyright © 2020 David R. Ferreira. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    
    @IBOutlet weak var newsTitle: UITextView!
    @IBOutlet weak var newsDescription: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var readMoreButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
