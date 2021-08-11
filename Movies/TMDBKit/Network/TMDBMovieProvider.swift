//
//  TMDBService.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 27/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation
import Combine

public struct TMDBMovieProvider {
    private init() {}
    
    public static func listMovies(searchType: TMDBSearchType, page: Int = 1 , completion: @escaping (_ movieArray:[TMDBMovie]?, _ totalOfMovies: Int?, _ error: Error?) -> (Void)){
        
        guard var urlComponents = URLComponents(string: searchType.endpoint) else {
            fatalError("Could not create an URL from TMDBSearchType")
        }
        
        guard let apiKey = TMDBConfiguration.apiKey, !apiKey.isEmpty else { fatalError("Setup the APIKey using TMDBConfiguration before perform a request") }
        
        var parameters = TMDBProvider.parameters
        parameters["page"] = "\(page)"
        
        TMDBUrlEncoder.encode(&urlComponents, withParameters: parameters)
        guard let url = urlComponents.url else {
            fatalError("It was not possible to parse url with parameters")
        }
        
        TMDBProvider.fetchData(fromURL: url, ofType: TMDBMoviesResponse.self) { (response, error) in
            completion(response?.result, response?.totalResults, error)
        }
    }
    
    public static func listMovies(searchType: TMDBSearchType, page: Int = 1) -> AnyPublisher<[TMDBMovie], Error> {
        
        guard var urlComponents = URLComponents(string: searchType.endpoint) else {
            fatalError("Could not create an URL from TMDBSearchType")
        }
        
        guard let apiKey = TMDBConfiguration.apiKey, !apiKey.isEmpty else { fatalError("Setup the APIKey using TMDBConfiguration before perform a request") }
        
        var parameters = TMDBProvider.parameters
        parameters["page"] = "\(page)"
        
        TMDBUrlEncoder.encode(&urlComponents, withParameters: parameters)
        guard let url = urlComponents.url else {
            fatalError("It was not possible to parse url with parameters")
        }
        
        let publisher = TMDBProvider.fetchData(fromURL: url, ofType: TMDBMoviesResponse.self)
            .compactMap { $0.result }
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    public static func search(name: String, page: Int = 1, completion: @escaping (_ movieArray:[TMDBMovie]?, _ totalOfMovies: Int?, _ error: Error?) -> (Void)) {
        
        guard let apiKey = TMDBConfiguration.apiKey, !apiKey.isEmpty else { fatalError("Setup the APIKey using TMDBConfiguration before perform a request") }
        
        let route = TMDBRoutes.searchMovie
        guard var urlComponents = URLComponents(string: route.string) else {
            fatalError("Could not create an URL from TMDBSearchType")
        }
        
        var parameters = TMDBProvider.parameters
        parameters["query"] = "\(name)"
        parameters["isAdult"] = "false"
        parameters["page"] = "\(page)"
        
        TMDBUrlEncoder.encode(&urlComponents, withParameters: parameters)
        guard let url = urlComponents.url else {
            fatalError("It was not possible to parse url with parameters")
        }
        
        TMDBProvider.fetchData(fromURL: url, ofType: TMDBMoviesResponse.self) { (response, error) in
            completion(response?.result, response?.totalResults , error)
        }
    }

    
    public static func detail(movieID id: Int, options: [TMDBMovieContentOptions]? = nil, completion: @escaping (TMDBMovie?, Error?) -> Void) {

        let route = TMDBRoutes.movie(id: id)
        guard var urlComponents = URLComponents(string: route.string) else {
            fatalError("Could not create an URL from TMDBSearchType")
        }
        
        guard let apiKey = TMDBConfiguration.apiKey, !apiKey.isEmpty else { fatalError("Setup the APIKey using TMDBConfiguration before perform a request") }
        
        var parameters = TMDBProvider.parameters
        if let options = options {
            parameters["append_to_response"] = options.map {$0.rawValue}.joined(separator: ",")
        }
        TMDBUrlEncoder.encode(&urlComponents, withParameters: parameters)
        guard let url = urlComponents.url else {
            fatalError("It was not possible to parse url with parameters")
        }
        
        TMDBProvider.fetchObject(fromURL: url, ofType: TMDBMovie.self) { (movie, error) in
            completion(movie, error)
        }
        
    }

}
