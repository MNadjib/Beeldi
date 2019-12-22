//
//  Equipement.swift
//  TechnicalTest
//
//  Created by nbellouni on 20/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit


struct Equipement {
    var brand: String?
    var building: String?
    var domain: String?
    var local: String?
    var model: String?
    var name: String?
    var nbFaults: Int?
    var niveau: String?
    var notes: String?
    var photo: String?
    var quantity: Int?
    var serialNumber: String?
    var status: String?
    
    init() {}
    
    init?(with dictionay: [String: Any]?) {
        guard let dico = dictionay else {
            return nil
        }
        brand = dico["brand"] as? String
        building = dico["building"] as? String
        domain = dico["domain"] as? String
        local = dico["local"] as? String
        model = dico["model"] as? String
        name = dico["name"] as? String
        nbFaults = dico["nbFaults"] as? Int
        niveau = dico["niveau"] as? String
        notes = dico["notes"] as? String
        photo = dico["photo"] as? String
        quantity = dico["quantity"] as? Int
        serialNumber = dico["serialNumber"] as? String
        status = dico["status"] as? String
    }
    
   
}
 