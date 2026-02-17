//
//  Network.swift
//  DemoProjectOne
//
//  Created by Sparsh Singh on 16/02/26.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case sessionError
    case responseError
    case stringError(String)
}

final class NetworkLayer {
    
    // Singleton Design Pattern
    static let sharedInstance = NetworkLayer()
    
    // Only one initilization
    private init() {
        print("Network Layer is Init.")
    }
    
    // Make your api calls via URL Session Data Task
    func request<T: Codable>(url : String, model: T.Type, completion : @escaping(Result<T, NetworkError>) -> Void) {
        
        guard url != "",
            let actualURL = URL(string : url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: actualURL)
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.sessionError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,  200...299 ~= response.statusCode else  {
                completion(.failure(.sessionError))
                return
            }
            
            print(String(data: data, encoding: .utf8))
            
            do {
                let decodor = JSONDecoder()
                let decodedData = try decodor.decode(T.self, from: data)
               completion(.success(decodedData))
            } catch {
                completion(.failure(.stringError(error.localizedDescription)))
            }
            
            
        }
        
        urlSession.resume()
    }
    
}
