//
//  NetworkLayer.swift
//  DemoProjectThree
//
//  Created by Sparsh Singh on 17/02/26.
//

enum NetworkError : Error {
    case invalidURL
    case invalidResponse
    case dataError
    case errorDescription(String)
    
}

import Foundation

protocol NetworkLayerProtocol {
    func sendRequest<T: Codable>(urlString : String, method : HttpMethod, model : T.Type, paramter : [String:Any], completion : @escaping(Result<T, NetworkError>) -> Void)
    
    func sendAsyncRequest<T: Codable>(urlString : String, httpMethod : HttpMethod, parameters : [String: Any]) async throws -> T
}

final class NetworkLayer : NetworkLayerProtocol{
    
    func sendRequest<T>(urlString: String, method: HttpMethod, model: T.Type, paramter: [String : Any], completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        //
    }
    
    
    static let shared = NetworkLayer()
    
    // So no object can be created
    private init() {}
    
  
    func sendAsyncRequest<T>(urlString: String, httpMethod: HttpMethod, parameters : [String: Any]) async throws -> T where T : Decodable, T : Encodable {
        guard let actualURL = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: actualURL)
        request.httpMethod = httpMethod.rawValue
        
        switch httpMethod {
        case .get :
            break
        case .post, .put, .delete :
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            break
        }
        
        if !parameters.isEmpty {
            let body = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = body
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
        
    }
}
