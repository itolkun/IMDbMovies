//
//  NetworkManager.swift
//  IMDbMovies
//
//  Created by Айтолкун Анарбекова on 8/11/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMovies(by movie: String, completion: @escaping(Result <SearchResult, NetworkError>) -> Void ) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=2d5a19e0&r=json&s=\(movie)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description" )
                return
            }
            let decoder = JSONDecoder()
            do {
                
                let searchResult = try decoder.decode(SearchResult.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(searchResult))
                    
                }
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
    func fetchMovieImage(from url: String, completion: @escaping (Result <Data, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
        
    }
    
    func fetchMovieInfo(by movieId: String, completion: @escaping(Result <Movie, NetworkError>) -> Void ) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=2d5a19e0&r=json&i=\(movieId)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description" )
                return
            }
            let decoder = JSONDecoder()
            do {
                
                let movieInfo = try decoder.decode(Movie.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(movieInfo))
                    
                }
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(.decodingError))
            }
        }.resume()
        
    }
    
}

