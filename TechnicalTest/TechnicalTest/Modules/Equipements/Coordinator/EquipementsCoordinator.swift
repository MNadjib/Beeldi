//
//  EquipementsCoordinator.swift
//  TechnicalTest
//
//  Created by nbellouni on 15/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

class EquipementsCoordinator {
    private let window: UIWindow
    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let equipementViewController = EquipementsViewController(nibName: "EquipementsViewController", bundle: Bundle.main)
        let nvc = UINavigationController(rootViewController: equipementViewController)
        let viewModel = EquipementsViewModel()
        equipementViewController.viewModel = viewModel
        window.rootViewController = nvc
    }
}
