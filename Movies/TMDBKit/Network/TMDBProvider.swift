//
//  TMDBProvider.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation
import Combine

struct TMDBProvider {
    
    typealias TMDBObject = Decodable & TMDBResponse
    private init() {}
    static let parameters: [String : String] = [
        "api_key" : TMDBConfiguration.apiKey ?? "",
        "language" : TMDBConfiguration.language,
    ]
    
    private static var task: URLSessionDataTask?
    
    static func fetchData<T: TMDBObject>(fromURL url: URL, ofType type: T.Type, completion: @escaping (T?, Error?) -> Void) {
        self.task?.cancel()
        let urlSession = URLSession.shared
        let request = URLRequest(url: url)
        self.task = urlSession.dataTask(with: request) { (responseData, response, error) in
            
            guard let data = responseData else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        self.task?.resume()
    }
    
    static func fetchData<T: TMDBObject>(fromURL url: URL, ofType type: T.Type) -> AnyPublisher<T, Error>{
        
        let urlSession = URLSession.shared
        let publisher = urlSession
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    static func fetchObject<T: Decodable>(fromURL url: URL, ofType type: T.Type, completion: @escaping (T?, Error?) -> Void) {
        self.task?.cancel()
        let urlSession = URLSession.shared
        let request = URLRequest(url: url)
        self.task = urlSession.dataTask(with: request) { (responseData, response, error) in
            
            guard let data = responseData else { completion(nil, error); return; }
            let jsonDecoder = JSONDecoder()
            do {
                let response = try jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(response, error)
                }
            } catch {
                print(error)
            }
            }
        self.task?.resume()
    }
    
}
