//
//  Equipement.swift
//  TechnicalTest
//
//  Created by nbellouni on 20/12/2019.
//  Copyright © 2019 nbellouni. All rights reserved.
//

import UIKit

struct Equipement {
    var equipmentKey: String = ""
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
    
    init(with dictionay: [String: Any]?, _ key: String) {
        equipmentKey = key
        guard let dico = dictionay else {
            return
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
 
