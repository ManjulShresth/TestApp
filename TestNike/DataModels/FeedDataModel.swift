//
//  FeedDataModel.swift
//  TestApp
//
//  Created by Manjul Shrestha on 8/3/20.
//  Copyright © 2020 Manjul Shrestha. All rights reserved.
//

import Foundation

struct FeedDataModel: Codable{
    var feed: Feed?
}

struct Feed: Codable{
    var title, id, copyright, country, icon, updated: String?
    var author : Author?
    var links: [[String: String]]?
    var results: [FeedResult]?
}

struct Author: Codable{
    var name, uri: String?
}

struct FeedResult: Codable{
    var artistName, id, releaseDate, name, kind, copyright, artistId, contentAdvisoryRating, artistUrl, artworkUrl100, url: String?
    var genres: [Genre]?
}

struct Genre: Codable{
    var genreId, name, url: String?
}
