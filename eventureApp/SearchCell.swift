//
//  SearchCell.swift
//  eventureApp
//
//  Created by Marco Roveto on 11/15/16.
//  Copyright © 2016 eventure-app. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(event: Event) {
        self.title.text = event.title_text
        //change this to what ever data i want viewed.
    }
    
}
