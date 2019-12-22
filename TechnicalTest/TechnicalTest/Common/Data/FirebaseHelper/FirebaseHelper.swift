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

enum DatebaseRefPath: String {
       case equipment = "Equipments"
       case checkpoints = "Checkpoints"
       
    var reference: DatabaseReference {
           Database.database().reference(withPath: self.rawValue)
    }
}

struct FirebaseHelper {
    
    private let ref: DatabaseReference
    private let refPath: DatebaseRefPath

    init(_ refPath: DatebaseRefPath) {
        self.refPath = refPath
        self.ref = refPath.reference
        self.ref.keepSynced(true)
    }
    
    func set() -> Observable<Any>? {
        return nil
    }
    
    func get() -> Observable<DataSnapshot> {
        return ref.rx.observeSingleEvent(.value)
            .subscribeOn(MainScheduler.instance)
            .asObservable()
    }
    
    func remove() -> Observable<Any>?  {
        return nil
    }
}





