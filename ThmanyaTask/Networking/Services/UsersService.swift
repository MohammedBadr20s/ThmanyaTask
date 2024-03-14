//
//  UsersService.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Alamofire


enum UsersService: URLRequestBuilder {
    case getUsers
    
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getUsers:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var analyticsName: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }
    
}
