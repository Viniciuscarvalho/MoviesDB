//
//  TMDBMovie.swift
//  TMDBKit
//
//  Created by Davi Cabral de Oliveira on 27/09/18.
//  Copyright © 2018 Davi Cabral de Oliveira. All rights reserved.
//

import Foundation

open class TMDBMovie: Decodable, Equatable {
    public var id: Int
    public var isAdult: Bool
    public var overview: String
    public var releaseDate: String
    public var originalTitle: String
    public var originalLanguage: String
    public var title: String
    public var popularity: Double
    public var voteCount: Int
    public var voteAverage: Double
    public var genres: [TMDBMovieGenre]?
    var posterPath: String?
    var backdropPath: String?
    //Get details
    public var budget: Int?
    public var homepage: String?
    public var imdbID: String?
    public var revenue: Int?
    public var runtime: Int?
    public var productionCompanies: [TMDBCompany]?
    public var productionCountries: [TMDBCountry]?
    public var crew: [TMDBCrew]?
    public var cast: [TMDBCast]?
    
    public func posterImage(withSize size: TMDBPosterSize) -> URL? {
        guard let posterPath = self.posterPath else { return nil }
        return TMDBImage.pathFrom(imagePath: posterPath, withSize: size)
    }
    
    public func backdropImage(withSize size: TMDBBackdropSize) -> URL? {
        guard let posterPath = self.backdropPath else { return nil }
        return TMDBImage.pathFrom(imagePath: posterPath, withSize: size)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case isAdult = "adult"
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreList = "genre_ids"
        case budget
        case homepage
        case imdbID = "imdb_id"
        case revenue
        case runtime
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case genres
        case credits
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.isAdult = try container.decode(Bool.self, forKey: .isAdult)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.title = try container.decode(String.self, forKey: .title)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        self.budget = try? container.decode(Int.self, forKey: .budget)
        self.homepage = try? container.decode(String.self, forKey: .homepage)
        self.imdbID = try? container.decode(String.self, forKey: .imdbID)
        self.revenue = try? container.decode(Int.self, forKey: .revenue)
        self.runtime = try? container.decode(Int.self, forKey: .runtime)
        self.productionCompanies = try? container.decode([TMDBCompany].self, forKey: .productionCompanies)
        self.productionCountries = try? container.decode([TMDBCountry].self, forKey: .productionCountries)
        
        let credits = try? container.decode(TMDBCredits.self, forKey: .credits)
        self.cast = credits?.cast
        self.crew = credits?.crew

        guard let genres = try? container.decode([TMDBMovieGenre].self, forKey: .genres) else {
            if let genresList = try? container.decode([Int].self, forKey: .genreList) {
                TMDBGenreProvider.getMoviesGenreList {  [weak self] (genres, error) in
                    self?.genres = genres?.filter({ genre in
                        return genresList.contains(genre.id)
                    })
                }
            }
            return 
        }
        self.genres = genres
    }

    public static func == (lhs: TMDBMovie, rhs: TMDBMovie) -> Bool {
        lhs.id == rhs.id &&
        lhs.overview == rhs.overview &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.originalTitle == rhs.originalTitle &&
        lhs.originalLanguage == rhs.originalLanguage
    }
}
