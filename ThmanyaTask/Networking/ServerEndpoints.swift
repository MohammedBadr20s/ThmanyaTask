//
//  ServerEndpoints.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation

enum Environment: String {
    
    case Default = ""
    case Production = "Production URL"
    case Staging = "https://jsonplaceholder.typicode.com"
    func changeTo() {
        UserDefaults.standard.setValue(self.rawValue, forKey: Constants.Environment.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func current() -> Environment? {
        return Environment(rawValue: UserDefaults.standard.value(forKey: Constants.Environment.rawValue) as? String ?? "Environment") ?? .Staging
    }
}

enum ServerEndpointsPath: String {
    case baseURL = "https://jsonplaceholder.typicode.com"
    
}
