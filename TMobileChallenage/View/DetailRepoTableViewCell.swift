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

    func setUpCellData(repoName: String, fork_count: Int, start_count: Int) {
        self.repoNameLabel.text = repoName
        self.statLabel?.text = """
        \(fork_count) Forks
        \(start_count) Stars
        """
        self.detailTextLabel?.textAlignment = .left
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
