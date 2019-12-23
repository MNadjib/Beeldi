//
//  Checkpoints.swift
//  TechnicalTest
//
//  Created by nbellouni on 22/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

struct Checkpoint {
    
    var equipmentKey: String?
    var fault: String?
    var name: String?
    var photo: String?
    var recommandation: String?
    
    init() {}
    
    init(with dictionay: [String: Any]?) {
        guard let dico = dictionay else {
            return
        }
        equipmentKey = dico["equipmentKey"] as? String
        fault = dico["fault"] as? String
        name = dico["name"] as? String
        photo = dico["photo"] as? String
        recommandation = dico["recommandation"] as? String
    }
}
