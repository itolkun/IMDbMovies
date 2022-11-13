//
//  NetworkManager.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMovies(by movie: String, completion: @escaping(Result <SearchResult, AFError>) -> Void ) {
        AF.request("https://www.omdbapi.com/?apikey=2d5a19e0&r=json&s=\(movie)")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let searchResult = SearchResult.getSearchResult(from: value)
                    completion(.success(searchResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchMovieImage(from url: String, completion: @escaping (Result <Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchMovieInfo(by movieId: String, completion: @escaping(Result <Movie, AFError>) -> Void ) {
        AF.request("https://www.omdbapi.com/?apikey=2d5a19e0&r=json&i=\(movieId)")
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let movieInfo = Movie.getMovieInfo(from: value)
                    completion(.success(movieInfo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}

