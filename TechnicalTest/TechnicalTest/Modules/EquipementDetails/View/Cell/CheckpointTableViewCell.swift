//
//  CheckpointTableViewCell.swift
//  TechnicalTest
//
//  Created by nbellouni on 23/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

class CheckpointTableViewCell: UITableViewCell {

    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var faultLbl: UILabel!
    @IBOutlet weak var recommandationLbl: UILabel!
    @IBOutlet weak var imgvWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var checkpoint: Checkpoint?{
        didSet {
            nameLbl.text = "\(localize("checkpoint")): \(checkpoint?.name ?? "")"
            faultLbl.text = "\(localize ("fault")): \(checkpoint?.fault ?? "")"
            recommandationLbl.text = "\(localize("recommandation")):  \(checkpoint?.recommandation ?? "")"
            if let ph = checkpoint?.photo, ph.count > 0 {
                imgv.loadImageAsync(with: ph)
                imgvWidthConstraint.constant = 80
            } else {
                imgvWidthConstraint.constant = 0
            }
        }
    }
}
