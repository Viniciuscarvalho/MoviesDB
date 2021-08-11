//
//  TMDBCache.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 30/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import UIKit

struct TMDBCache {
    fileprivate init() { }
    
    
    static fileprivate func getURL() -> URL {
        if let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create url for cache directory")
        }
    }
    
    static func save<T: Encodable>(_ object: T, as fileName: String) {
        let url = getURL().appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            print(error)
//            fatalError(error.localizedDescription)
        }
        
    }
    
    static func load<T: Decodable>(_ fileName: String, as type: T.Type) -> T {
        let url = getURL().appendingPathComponent(fileName, isDirectory: false)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File at \(url.path) doesn't exists")
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(url.path)")
        }
        
    }
    
    static func remove(_ fileName: String) {
        let url = getURL().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    static func fileExists(_ fileName: String) -> Bool {
        let url = getURL().appendingPathComponent(fileName, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }

}
