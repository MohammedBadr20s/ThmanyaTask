//
//  AlbumsService.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/14/24.
//

import Alamofire

enum AlbumsService: URLRequestBuilder {
    case getAlbums(userId: Int)
    
    var path: String {
        switch self {
        case .getAlbums:
            return "/albums"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAlbums(let id):
            return [
                "userId": id
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAlbums:
            return .get
        }
    }
    
    var analyticsName: String {
        switch self {
        case .getAlbums:
            return "/albums"
        }
    }
    
}
