//
//  TMDBMoviesResponse.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 27/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

struct TMDBMoviesResponse: Decodable, TMDBResponse {
    var result: [TMDBMovie]?
    var error: TMDBError?
    var success: Bool?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
        case success
        case error = "status_code"
        case totalResults = "total_results"
    }
}
