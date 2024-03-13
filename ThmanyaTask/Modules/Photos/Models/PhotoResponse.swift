//
//  AlbumeResponse.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Codable, Hashable {
    var albumID, id: Int?
    var title: String?
    var url, thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
