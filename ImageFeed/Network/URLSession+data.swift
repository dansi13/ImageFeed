//
//  URLSession+data.swift
//  ImageFeed
//
//  Created by Daniil Sivachenko on 19.10.2026.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
    case decodingError(Error)
}

extension URLSession {
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionTask {
        
        let fulfillCompletionOnTheMainThread: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request) { data, response, error in
            if let data,
               let response,
               let statusCode = (response as? HTTPURLResponse)?.statusCode {
                
                if 200..<300 ~= statusCode {
                    fulfillCompletionOnTheMainThread(.success(data))
                } else {
                    print("HTTP error. Status code:", statusCode)
                    
                    fulfillCompletionOnTheMainThread(
                        .failure(NetworkError.httpStatusCode(statusCode))
                    )
                }
                
            } else if let error {
                print("Network error:", error)
                
                fulfillCompletionOnTheMainThread(
                    .failure(NetworkError.urlRequestError(error))
                )
            } else {
                print("URLSession error")
                
                fulfillCompletionOnTheMainThread(
                    .failure(NetworkError.urlSessionError)
                )
            }
        }
        
        return task
    }
}
