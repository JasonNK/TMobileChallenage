//
//  DetailRepoTableViewCell.swift
//  TMobileChallenage
//
//  Created by Jason on 4/27/20.
//  Copyright © 2020 Jason. All rights reserved.
//

import UIKit

class DetailRepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
