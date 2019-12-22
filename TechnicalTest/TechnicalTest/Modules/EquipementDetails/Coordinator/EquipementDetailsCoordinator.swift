//
//  EquipementDetailsCoordinator.swift
//  TechnicalTest
//
//  Created by nbellouni on 21/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

class EquipementDetailsCoordinator {
    let equipement: Equipement
    var equipemetDetailsViewContoller: EquipementDetailsViewController!
    init(with equipement: Equipement) {
        self.equipement = equipement
    }
    
    func start() {
        equipemetDetailsViewContoller = EquipementDetailsViewController(nibName: "EquipementDetailsViewController", bundle: nil)
        
    }
}
