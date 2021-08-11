//
//  TMDBConfiguration.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 27/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public struct TMDBConfiguration {
    
    static var apiKey: String?
    static var language: String = "en-US"
    
    private init(){}
    
    public static func setup(withKey key: String, andLanguage language: String = "en-US") {
        TMDBConfiguration.apiKey = key
        TMDBConfiguration.language = language
    }
}

