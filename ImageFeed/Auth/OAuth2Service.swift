//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 08.10.2026.
//

import Foundation

nonisolated struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    private let tokenStorage = OAuth2TokenStorage()
    
    private init() {}
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard var urlComponents = URLComponents(
            string: "https://unsplash.com/oauth/token"
        ) else {
            return nil
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        guard let authTokenURL = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: authTokenURL)
        request.httpMethod = "POST"
        
        return request
    }
    
    func fetchOAuthToken(
        code: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.data(for: request) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(
                        OAuthTokenResponseBody.self,
                        from: data
                    )
                    
                    self?.tokenStorage.token = response.accessToken
                    completion(.success(response.accessToken))
    
                } catch {
                    print("Decoding error:", error)
                    
                    completion(
                        .failure(NetworkError.decodingError(error))
                    )
                }
                
            case .failure(let error):
                print("OAuth request error:", error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
