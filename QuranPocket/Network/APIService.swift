//
//  APIService.swift
//  QuranPocket
//
//  Created by Agung Dwi Saputra on 11/04/23.
//

import Foundation


class APIService {
    
    public typealias JSON = [String: Any]
    
    func craeteRequest<T: Codable>(type: BaseURL,
                                   method: HttpMethod,
                                   bodyRequest: [String: Any],
                                   completion: @escaping (Result<T, Error>) -> ()) {
        var component = URLComponents()
        component.host = type.rawValue
        component.scheme = "https"
        
        guard let url = component.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask? = nil
        switch method {
        case .get:
            dataTask = getRequest(session: defaultSession, urlRequest: urlRequest, completion: completion)
        case .post:
            dataTask = postRequest(session: defaultSession, urlRequest: &urlRequest, bodyRequest: bodyRequest)
        }
        
        dataTask?.resume()
        
        
    }
    
    private func getRequest<T: Codable>(session: URLSession, urlRequest: URLRequest,
                                        completion: @escaping (Result<T, Error>) -> ()) -> URLSessionDataTask {
        return session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                return
            }
            guard response != nil, let data = data else {
                return
            }
            
        }
    }
    
    private func postRequest(session: URLSession, urlRequest: inout URLRequest, bodyRequest: [String: Any]) -> URLSessionDataTask {
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyRequest)
        return session.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            
        }
    }
    
    
}
