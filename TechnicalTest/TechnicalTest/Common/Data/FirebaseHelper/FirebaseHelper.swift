//
//  FirebaseHelper.swift
//  TechnicalTest
//
//  Created by nbellouni on 19/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit
import RxSwift
import RxFirebase
import FirebaseDatabase

//Helper to mange data in firebase data base
// Action set and get

enum DatebaseRefPath: String {
       case equipment = "Equipments"
       case checkpoints = "Checkpoints"
       
    var reference: DatabaseReference {
           Database.database().reference(withPath: self.rawValue)
    }
}

struct FirebaseHelper {
    
    let ref: DatabaseReference
    private let refPath: DatebaseRefPath

    init(_ refPath: DatebaseRefPath) {
        self.refPath = refPath
        self.ref = refPath.reference
        self.ref.keepSynced(true)
    }
    
    func set( _ childPath: String ,  _ values: [String: Any]) -> Observable<DatabaseReference> {
        return ref.child(childPath)
            .rx.updateChildValues(values)
            .subscribeOn(MainScheduler.instance)
            .asObservable()
    }
    
    func get(filter: [String: Any] = [:]) -> Observable<DataSnapshot> {
        if filter.count > 0 {
            var query = ref.queryOrdered(byChild: filter.first!.key).queryEqual(toValue: filter.first?.value)
            var i = 0
            for item in filter {
                if i > 0 {
                   query = query.queryOrdered(byChild: item.key).queryEqual(toValue: item.value)
                }
                i += 1
            }
            return query.rx.observeSingleEvent(.value)
                       .subscribeOn(MainScheduler.instance)
                       .asObservable()
        } else {
            return ref.rx.observeSingleEvent(.value)
            .subscribeOn(MainScheduler.instance)
                .asObservable()
        }
    }
    
    func remove() -> Observable<Any>?  {
        return nil
    }
}





