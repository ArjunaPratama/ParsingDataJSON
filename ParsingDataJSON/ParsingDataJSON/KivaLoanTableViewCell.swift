//
//  KivaLoanTableViewCell.swift
//  ParsingDataJSON
//
//  Created by DOTS2 on 11/1/17.
//  Copyright © 2017 Arjuna. All rights reserved.
//

import UIKit

class KivaLoanTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelUse: UILabel!
    @IBOutlet weak var LabelCountry: UILabel!
    @IBOutlet weak var LabelName: UILabel!
    @IBOutlet weak var LabelAmount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
