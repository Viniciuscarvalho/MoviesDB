//
//  TMDBMoviesGenreResponse.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

struct TMDBMoviesGenreResponse: Decodable, TMDBResponse {
    var result: [TMDBMovieGenre]?
    var error: TMDBError?
    var success: Bool?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case result = "genres"
        case success
        case error = "status_code"
    }
}
