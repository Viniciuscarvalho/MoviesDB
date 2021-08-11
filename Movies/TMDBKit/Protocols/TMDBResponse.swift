//
//  TMDBResponse.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

protocol TMDBResponse {
    associatedtype ResponseObject
    var result: ResponseObject? {get set}
    var error: TMDBError? {get set}
    var success: Bool? {get set}
    var totalResults: Int? {get set}
}
