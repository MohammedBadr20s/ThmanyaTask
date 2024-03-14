//
//  AlbumResponse.swift
//  ThmanyaTask
//
//  Created by Mohammedbadr on 3/13/24.
//

import Foundation

// MARK: - UsersResponseElement
struct UsersResponse: Codable, Hashable {
    var id: Int?
    var name, username, email: String?
    var address: Address?
    var phone, website: String?
    var company: Company?
    
    
    static func == (lhs: UsersResponse, rhs: UsersResponse) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Address
struct Address: Codable, Hashable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
    var fullAddress: String {
        return "\(street ?? ""), \(suite ?? ""), \(city ?? ""), \(zipcode ?? "")"
    }
}

// MARK: - Geo
struct Geo: Codable, Hashable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable, Hashable {
    var name, catchPhrase, bs: String?
}
