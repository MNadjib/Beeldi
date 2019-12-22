//
//  Environment.swift
//  TechnicalTest
//
//  Created by nbellouni on 18/12/2019.
//  Copyright © 2019 c2s. All rights reserved.
//

import UIKit

public enum Environment {
    case configuration
    case googleService
    case enableLog
    
    private var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    private func plistKey() -> String {
        switch self {
        case .configuration:
            return "Config"
        case .googleService:
            return "Google_Service_File"
        case .enableLog:
            return "Enable_Log"
        }
    }
    
    public func value () -> String{
        return (infoDict[self.plistKey()] as! String).replacingOccurrences(of: "\\", with: "")
    }
    
}

