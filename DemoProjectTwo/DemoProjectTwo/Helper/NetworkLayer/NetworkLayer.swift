//
//  NetworkLayer.swift
//  DemoProjectTwo
//
//  Created by Sparsh Singh on 16/02/26.
//

import Foundation

enum RequestType : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError : Error {
    case invalidString
    case parameterEncodingError
    case error(String)
}

final class NetworkLayer {
    
    // Singleton
    static let shared = NetworkLayer()
    
    // No Init outside the scope
    private init() {
        debugPrint("Network Layer is init.")
    }
    
    func sendRequest<T: Codable>(urlString : String, paramater : [String: Any] = [:], model : T.Type, requestType : RequestType, completionHandler : @escaping(Result<T, NetworkError>) -> (Void) ) {
        
        guard let actualUrl = URL(string : urlString) else {
            completionHandler(.failure(.invalidString))
            return
        }
        
        var request = URLRequest(url: actualUrl)
        request.httpMethod = requestType.rawValue
        
        switch requestType {
        case .get:
            break
        case .post, .put, .delete:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: paramater, options: [])
            } catch {
                completionHandler(.failure(.parameterEncodingError))
            }
        }
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completionHandler(.failure(.error(error?.localizedDescription ?? "Data Error")))
                return
            }
//            
//            let dataString = String(data: data, encoding: .utf8)
            
            do {
                let decodor = JSONDecoder()
                let decodedData = try decodor.decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.error(error.localizedDescription)))
            }
            
        }
        
        urlSession.resume()
        
        
    }
    
}
