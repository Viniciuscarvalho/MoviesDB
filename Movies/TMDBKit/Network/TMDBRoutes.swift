//
//  TMDBRoutes.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

enum TMDBRoutes {
    
    case moviesGenre
    case movie(id: Int)
    case movieNowPlaying
    case movieUpcoming
    case searchMovie
    
    
    private static var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    private var route: String {
        switch self {
        case .moviesGenre:
            return "/genre/movie/list"
        case .movie(let id):
            return "/movie/\(id)"
        case .movieNowPlaying:
            return "/movie/now_playing"
        case .movieUpcoming:
            return "/movie/upcoming"
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    var string: String {
        return "\(TMDBRoutes.baseURL)\(self.route)"
    }
    
    var url: URL? {
        return URL(string: "\(TMDBRoutes.baseURL)\(self.route)")
    }
    
}
