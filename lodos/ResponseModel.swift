//
//  ResponseModel.swift
//  lodos
//
//  Created by Efe Mazlumoğlu on 20.09.2020.
//  Copyright © 2020 Efe Mazlumoğlu. All rights reserved.
//

import Foundation

public struct ResponseModel {
    public let Title: String
    public let Year: String
    public let Rated: String
    public let Released: String
    public let Runtime: String
    public let Genre: String
    public let Director: String
    public let Writer: String
    public let Actors: String
    public let Plot: String
    public let Language: String
    public let Country: String
    public let Awards: String
    public let Poster: String
    public let Ratings: RateModel
    public let Metascore: String
    public let imdbRating: String
    public let imdbVotes: String
    public let imdbID: String
    public let `Type`: String
    public let DVD: String
    public let BoxOffice: String
    public let Production: String
    public let Website: String
    public let Response: String
}

public struct RateModel {
    public let Source: String
    public let Value: String
}
