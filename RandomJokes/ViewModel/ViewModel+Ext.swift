//
//  JokeError.swift
//  RandomJokes
//
//  Created by wahid tariq on 09/05/25.
//

import Foundation

extension ViewModel {
    
    enum JokeError: Error {
        case invalidURL
        case failedWithError(Error)
    }
    
    enum ViewState {
        case loading
        case loaded
        case error(Error)
    }
}
