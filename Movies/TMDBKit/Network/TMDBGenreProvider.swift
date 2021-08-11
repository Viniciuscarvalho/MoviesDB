//
//  TMDBGenreProvider.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public struct TMDBGenreProvider {
    private init() {}
    
    static func getMoviesGenreList(completion: @escaping ([TMDBMovieGenre]?, Error?) -> Void) {
        let stringURL = TMDBRoutes.moviesGenre.string
        guard var urlComponents = URLComponents(string: stringURL) else {
            fatalError("Could not create genre list endpoint")
        }
        TMDBUrlEncoder.encode(&urlComponents, withParameters: TMDBProvider.parameters)

        guard let url = urlComponents.url else {
            fatalError("It was not possible to parse url with parameters")
        }
        
        if !TMDBCache.fileExists(TMDBMovieGenre.fileName) {
            TMDBProvider.fetchData(fromURL: url, ofType: TMDBMoviesGenreResponse.self) { (genres, error) in
                TMDBCache.save(genres?.result, as: TMDBMovieGenre.fileName)
                completion(genres?.result, error)
            }
        } else {
            let genres = TMDBCache.load(TMDBMovieGenre.fileName, as: [TMDBMovieGenre].self)
            completion(genres, nil)
        }
    }
}
