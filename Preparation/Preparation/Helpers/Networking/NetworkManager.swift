//
//  NetworkManager.swift
//  Preparation
//
//  Created by Sparsh Singh on 15/02/26.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case serverError
    case decodeError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func sendRequest<T: Decodable>(urlString : String, param : [String : Any] = [:], completion : @escaping(Result<T, NetworkError>) -> (Void)) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let urlSession = URLSession.shared
        urlSession.dataTask(with: request) { data, response, error in
            guard let data = data, error != nil else {
                completion(.failure(.serverError))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodeError))
            }
        }
        
    }
}
