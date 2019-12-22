//
//  EquipementTableViewCell.swift
//  TechnicalTest
//
//  Created by nbellouni on 19/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

class EquipementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgv: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var domainLbl: UILabel!
    @IBOutlet weak var nbFautsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var equipement:Equipement = Equipement() {
        didSet {
            nameLbl.text = equipement.name
            domainLbl.text = equipement.domain
            if let nbf = equipement.nbFaults {
                nbFautsLbl.text = "\(nbf)"
            }
            if let ph = equipement.photo {
                imgv.loadImageAsync(with: ph)
            }
        }
    }
    
    var searchedText: String = "" {
        didSet {
            if let name = equipement.name {
                let range = (name as NSString).range(of: searchedText)
                let attributedStringName = NSMutableAttributedString(string: name)
                attributedStringName.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: nameLbl.font.pointSize + 2), range: range)
                nameLbl.attributedText = attributedStringName
            }
            
            if let domain = equipement.domain {
                let range = (domain as NSString).range(of: searchedText)
                let attributedStringDomain = NSMutableAttributedString(string: domain)
                attributedStringDomain.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: domainLbl.font.pointSize + 2), range: range)
                domainLbl.attributedText = attributedStringDomain
            }
        }
    }
}
