//
//  EquipementDetailsCoordinator.swift
//  TechnicalTest
//
//  Created by nbellouni on 21/12/2019.
//  Copyright © 2019 nbellouni. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RxSwift
import RxCocoa

//Coordinator for navigation and dependencies injections

class EquipementDetailsCoordinator {
    var equipemetDetailsViewContoller: EquipementDetailsViewController!
    private let disposeBag = DisposeBag()
    
    func start(with eqipement: Equipement) {
        let checkpointsFirebase = FirebaseHelper(.checkpoints)
        let equipementsFirebase = FirebaseHelper(.equipment)
        equipemetDetailsViewContoller = EquipementDetailsViewController(nibName: "EquipementDetailsViewController", bundle: nil)
        let viewModel = EquipementDetailsViewModel(with: checkpointsFirebase, equipementsFirebase,eqipement)
        equipemetDetailsViewContoller.viewModel = viewModel
        viewModel.viewDeleagate = equipemetDetailsViewContoller
        
        viewModel.updateInfoEquipement.catchError({ [weak self]   error -> Observable<DatabaseReference> in
            let alertController = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
           alertController.addAction(defaultAction)
            self?.equipemetDetailsViewContoller.present(alertController, animated: true, completion: nil)
            return Observable.of(equipementsFirebase.ref)
        }).subscribe(onNext: { data in
            log(data.child(eqipement.equipmentKey))
            }).disposed(by: disposeBag)
    }
}
