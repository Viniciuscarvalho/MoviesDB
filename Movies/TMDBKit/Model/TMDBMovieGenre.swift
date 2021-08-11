//
//  TMDBMovieGenre.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public struct TMDBMovieGenre: Codable {
    
    static let fileName = "genresList"
    public let id: Int
    public let name: String
}
