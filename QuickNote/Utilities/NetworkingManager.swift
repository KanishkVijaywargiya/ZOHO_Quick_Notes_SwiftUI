//
//  NetworkingManager.swift
//  QuickNote
//
//  Created by Kanishk Vijaywargiya on 10/09/22.
//

import SwiftUI
import Combine

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        // we have made a url as a parameter in above case to print url with error.
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap ({try handleOutput(output: $0, url: url)})
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleOutput(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    // use this code in sink when don't want to use .replaceError(with: [])
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Error downloading data: \(error)")
        }
    }
}

// we have created a static func, so that we never required to initialize the class, we can call NetworkingManager.download ...if use regular func, then we need to initialize an instance of a class to access this.
