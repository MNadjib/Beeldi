//
//  Error.swift
//  TechnicalTest
//
//  Created by nbellouni on 19/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

public enum Error: Swift.Error {
    case invalidPath
    case errorFetchingEquipements

    var localizedDescription: String {
        switch self {
        case .invalidPath:
            return "Invalide url"
        case .errorFetchingEquipements:
            return "Impossible de recupérér les équipements"
        }
    }
}
