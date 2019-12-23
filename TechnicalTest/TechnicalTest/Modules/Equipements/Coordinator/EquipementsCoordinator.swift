//
//  EquipementsCoordinator.swift
//  TechnicalTest
//
//  Created by nbellouni on 15/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

//Coordinator for navigation and dependencies injections
class EquipementsCoordinator {
    
    private let window: UIWindow
    private let disposeBag = DisposeBag()
    private var equipementdetailCoordinator: EquipementDetailsCoordinator!
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let firebasee = FirebaseHelper(.equipment)
        let equipementViewController = EquipementsViewController(nibName: "EquipementsViewController", bundle: nil)
        let nvc = UINavigationController(rootViewController: equipementViewController)
        let viewModel = EquipementsViewModel(with: firebasee)
        equipementViewController.viewModel = viewModel
        window.rootViewController = nvc
        viewModel.presentEquipementDetails.subscribe(onNext: { [unowned self] equipement in
            let ed = EquipementDetailsCoordinator()
            ed.start(with: equipement)
            equipementViewController.navigationController?.pushViewController(ed.equipemetDetailsViewContoller, animated: true)
            self.equipementdetailCoordinator = ed
        }).disposed(by: disposeBag)
    }
}
