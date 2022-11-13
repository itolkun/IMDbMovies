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
    
    init(movieData: [String: Any]) {
        title = movieData["Title"] as? String ?? ""
        year = movieData["Year"] as? String ?? ""
        imdbID = movieData["imdbID"] as? String ?? ""
        type = movieData["Type"] as? String ?? ""
        poster = movieData["Poster"] as? String ?? ""
    }
    
    static func getMovieInfo(from value: Any) -> Movie {
        if let movieInfo = value as? [String: Any] {
            return Movie(movieData: movieInfo)
        }
        return Movie(movieData: [:])
    }
    
    
    static func getMovies(from value: Any) -> [Movie] {
        guard let movieData = value as? [[String: Any]] else { return []}
        return movieData.map { Movie(movieData: $0) }
        
    }

}

struct SearchResult: Decodable {
    let movies: [Movie]
    let totalResults: String
    let response: String
    
    init (searchResult: [String: Any]) {
        movies = Movie.getMovies(from: searchResult["Search"] ?? [])
        totalResults = searchResult["totalResults"] as? String ?? ""
        response = searchResult["Response"] as? String ?? ""
    }
    
    static func getSearchResult(from value: Any) -> SearchResult {
        if let searchData = value as? [String: Any] {
            return SearchResult(searchResult: searchData)
        }
        return SearchResult(searchResult: [:])
    }
}



