//
//  AlbumResponse.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation

// MARK: - AlbumsResponseElement
struct AlbumsResponse: Codable, Hashable {
    var userID, id: Int?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
