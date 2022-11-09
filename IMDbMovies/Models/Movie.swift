//
//  Film.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }

}

struct SearchResult: Decodable {
    let movies: [Movie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }

}



