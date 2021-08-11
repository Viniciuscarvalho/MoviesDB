//
//  TMDBCompany.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 01/10/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public struct TMDBCompany: Codable {
    public let id: Int
    public let name: String
    public let originCountry: String
    public let logoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case originCountry = "origin_country"
        case logoPath = "logo_path"
    }
}
