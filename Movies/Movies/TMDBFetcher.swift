//
//  TMDBFetcher.swift
//  Movies
//
//  Created by Davi Cabral de Oliveira on 19/05/21.
//

import Foundation
import TMDBKit
import Combine

struct TMDBFetcher {
    
    func fetchMovies(_ completion: @escaping (Result<[TMDBMovie], Error>) -> Void) {
        TMDBMovieProvider.listMovies(searchType: .nowPlaying) { movieArray, totalOfMovies, error in
            guard let movies = movieArray else {
                completion(.failure(error!))
                return
            }
            completion(.success(movies))
        }
    }
    
    func fetchMovies() -> AnyPublisher<[TMDBMovie], Error> {
        let publi = TMDBMovieProvider.listMovies(searchType: .nowPlaying)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        return publi
    }
    
}
