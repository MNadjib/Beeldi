//
//  EquipementDetailsViewModel.swift
//  TechnicalTest
//
//  Created by nbellouni on 21/12/2019.
//  Copyright © 2019 nbellouni. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RxSwift
import RxCocoa

protocol EquipementDetailsViewModelProtocol: class {
     // MARK: - Input
    var editInfoEquipement: PublishSubject<[String: String]> { get }
    func retrieveData()
     // MARK: - Output
    var updateInfoEquipement: Observable<DatabaseReference> { get}
    var nomberOfRow: Int {get}
    var equipementInfoData: Equipement { get }
    func checkPointData(for row: Int)-> Checkpoint?
}

class EquipementDetailsViewModel: EquipementDetailsViewModelProtocol {
    
    weak var viewDeleagate: EquipementDetailsViewControllerProtocol?
    var updateInfoEquipement: Observable<DatabaseReference>
    var editInfoEquipement: PublishSubject<[String: String]> = PublishSubject<[String: String]>()
    
    func retrieveData() {
        fetchedDatas.subscribe(onNext: { [weak  self] checkpoints in
            self?.retrivedData = checkpoints
            self?.viewDeleagate?.reloadData()
        }, onError: { error in
            log(error)
        }).disposed(by: disposeBag)
    }
    
    var nomberOfRow: Int {
        return self.retrivedData.count
    }
    
    var equipementInfoData: Equipement {
        return currentEquipement
    }
    
    func checkPointData(for row: Int) -> Checkpoint? {
        return retrivedData[row]
    }
    
    private let disposeBag = DisposeBag()
    private var fetchedDatas: Observable<[Checkpoint]>
    private var retrivedData: [Checkpoint] = []
    private var currentEquipement: Equipement
    
    init(with checkPointsFirebase: FirebaseHelper, _ equipementFirebase: FirebaseHelper, _ equipement: Equipement) {
        currentEquipement  = equipement
        fetchedDatas = checkPointsFirebase.get(filter: ["equipmentKey": equipement.equipmentKey] )
            .map({ data -> [Checkpoint] in
            let list = data.children.allObjects
            return list.map { item -> Checkpoint? in
                if let snap = item as? DataSnapshot {
                    return Checkpoint(with: snap.value as? [String: Any] )
                }
                return nil
            }.compactMap { $0 }
        })
        
        updateInfoEquipement = editInfoEquipement
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asObservable().flatMapLatest { (value) -> Observable<DatabaseReference> in
                return equipementFirebase.set( equipement.equipmentKey, value).catchError { error  in
                    Observable.error(error)
                }
        }
    }
}
