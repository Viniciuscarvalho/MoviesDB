//
//  TMDBError.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

enum TMDBError: Int, LocalizedError, Codable {
    case invalidService = 2
    case authenticationFailed = 3
    case invalidFormat = 4
    case invalidParameters = 5
    case invalidID = 6
    case invalidAPIKey = 7
    case duplicateEntry = 8
    case serviceOffline = 9
    case suspendedAPIKey = 10
    case internalError = 11
    case failed = 15
    case deviceDenied = 16
    case sessionDenied = 17
    case validationFailed = 18
    
    var errorDescription: String? {
        let caseName = String(describing: self)
        let bundle = Bundle(for: TMDBMovie.self)
        return bundle.localizedString(forKey: caseName, value: "", table: "ErrorHandling")
    }
}
