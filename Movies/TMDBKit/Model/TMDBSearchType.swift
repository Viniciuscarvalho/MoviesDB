//
//  TMDBSearchType.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 27/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public enum TMDBSearchType: String, CaseIterable {
    
    case nowPlaying = "now_playing"
    case upcoming
//    case next

    var endpoint: String {
        switch self {
        case .nowPlaying:
            return TMDBRoutes.movieNowPlaying.string
        case .upcoming:
            return TMDBRoutes.movieUpcoming.string
//        case .next:
//            return TMDBRoutes.movie.string
        }
    }
}
