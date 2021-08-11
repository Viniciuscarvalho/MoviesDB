//
//  TMDBMovieTests.swift
//  TMDBKitTests
//
//  Created by Davi Cabral de Oliveira on 27/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import XCTest
@testable import TMDBKit

class TMDBMovieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_parse_movie() {
        let bundle = Bundle(for: TMDBMovieTests.self)
        let path = bundle.url(forResource: "movie", withExtension: "json")
        XCTAssertNotNil(path)
        let movieData = try? Data(contentsOf: path!)
        XCTAssertNotNil(movieData)
        
        let jsonDecoder = JSONDecoder()
        let movie = try? jsonDecoder.decode(TMDBMovie.self, from: movieData!)
        XCTAssertNotNil(movie)
        XCTAssertNotNil(movie?.cast)
        XCTAssertNotNil(movie?.crew)
        
        XCTAssertEqual(movie?.title, "Jack Reacher: Never Go Back")
        
    }

}
