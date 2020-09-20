//
//  ResponseModel.swift
//  lodos
//
//  Created by Efe Mazlumoğlu on 20.09.2020.
//  Copyright © 2020 Efe Mazlumoğlu. All rights reserved.
//

import Foundation

public struct RootResponse: Decodable {
    var success: ResponseModel
}

public struct ResponseModel: Decodable {
    public var Title: String
    public var Year: String
    public var Rated: String
    public var Released: String
    public var Runtime: String
    public var Genre: String
    public var Director: String
    public var Writer: String
    public var Actors: String
    public var Plot: String
    public var Language: String
    public var Country: String
    public var Awards: String
    public var Poster: String
    public var Ratings:[[String : String]]
    public var Metascore: String
    public var imdbRating: String
    public var imdbVotes: String
    public var imdbID: String
    public var `Type`: String
    public var DVD: String
    public var BoxOffice: String
    public var Production: String
    public var Website: String
    public var Response: String
}
