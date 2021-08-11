//
//  TMDBCast.swift
//  TMDBKit
//
//  Created by Davi Cabral on 03/10/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public struct TMDBCast: Decodable {
    
    public let castID: Int
    public let character: String
    public let creditID: String
    public let gender: Int
    public let id: Int
    public let name: String
    public let order: Int
    public let profilePath: String?
    
    public func profileImage(withSize size: TMDBProfileSize) -> URL? {
        guard let path = self.profilePath else { return nil }
        return TMDBImage.pathFrom(imagePath: path, withSize: size)
    }
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender
        case id
        case name
        case order
        case profilePath = "profile_path"
    }
}
