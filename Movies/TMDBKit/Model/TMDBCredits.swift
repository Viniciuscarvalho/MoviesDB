//
//  TMDBCredits.swift
//  TMDBKit
//
//  Created by Davi Cabral on 03/10/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

public struct TMDBCredits: Decodable {
    var cast: [TMDBCast]
    var crew: [TMDBCrew]
}
