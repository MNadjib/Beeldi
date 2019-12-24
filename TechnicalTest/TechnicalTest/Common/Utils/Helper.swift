//
//  Helper.swift
//  TechnicalTest
//
//  Created by nbellouni on 19/12/2019.
//  Copyright © 2019 nbellouni. All rights reserved.
//

import UIKit

func localize(_ value: String) -> String {
    return NSLocalizedString(value, comment: "")
}

func log(_ item: Any) {
    if (Int(Environment.enableLog.value()) == 1) { // define log level
        print(item)
    }
}
