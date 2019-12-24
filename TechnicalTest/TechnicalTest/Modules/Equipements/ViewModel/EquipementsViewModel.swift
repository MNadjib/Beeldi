//
//  EquipementsViewModel.swift
//  TechnicalTest
//
//  Created by nbellouni on 15/12/2019.
//  Copyright © 2019 nbellouni. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RxSwift
import RxCocoa


protocol EquipementsViewModelProtocol {
    
    // MARK: - Input
    var searchText: PublishSubject<String> { get }
    var selectCell: PublishSubject<Int> { get }
    
    // MARK: - Output
    var fetchedDatas: Observable<[Equipement]> { get }
    var presentEquipementDetails: Observable<Equipement> {get}
}

class EquipementsViewModel: EquipementsViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    var presentEquipementDetails: Observable<Equipement>
    var fetchedDatas: Observable<[Equipement]>
    
    var searchText: PublishSubject<String> = PublishSubject<String>()
    var selectCell: PublishSubject<Int> = PublishSubject<Int>()
    
    init(with firebase: FirebaseHelper) {
        let searchedText = searchText
            .startWith("")
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        let allEquipements = firebase.get().map { data -> [Equipement] in
                   let list = data.children.allObjects
                   return list.map { item -> Equipement? in
                       if let snap = item as? DataSnapshot {
                        return Equipement(with: snap.value as? [String: Any], snap.key)
                       }
                       return nil
                   }.compactMap { $0 }
                    .sorted(by: {$0.name ?? "" < $1.name ?? ""})
        }
        
        fetchedDatas = Observable.combineLatest(allEquipements, searchedText) {equipements, text in
            (equipements, text)
        }.map({ equipements, text -> [Equipement] in
            if text.count == 0 {
                return equipements
            }
            return equipements.filter{ $0.name?.contains(text) ?? false || $0.domain?.contains(text) ?? false }
        })
        
        presentEquipementDetails = selectCell
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance).withLatestFrom(allEquipements) {row, equipements  in
            equipements[row]
        }
    }
}


