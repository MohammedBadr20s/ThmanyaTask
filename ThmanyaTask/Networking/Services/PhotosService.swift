//
//  PhotosService.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/14/24.
//

import Alamofire

enum PhotosService: URLRequestBuilder {
    case getPhotos(albumId: Int)
    
    var path: String {
        switch self {
        case .getPhotos:
            return "/photos"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getPhotos(let id):
            return [
                "albumId": id
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var analyticsName: String {
        switch self {
        case .getPhotos:
            return "/photos"
        }
    }
    
}
