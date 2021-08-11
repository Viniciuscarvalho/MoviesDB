//
//  TMDBImageRepresentable.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 01/10/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

protocol TMDBImageRepresentable {
    var value: String { get }
}

extension TMDBImageRepresentable where Self: RawRepresentable, Self.RawValue == String  {
    var value: String {
        return self.rawValue
    }
}
