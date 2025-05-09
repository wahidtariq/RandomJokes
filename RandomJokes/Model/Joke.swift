//
//  Joke.swift
//  RandomJokes
//
//  Created by wahid tariq on 09/05/25.
//

import Foundation

struct Joke: Codable, Identifiable {
    
    let id: String
    let joke: String
    let status: Int
    
    static var example: Joke {
        Joke(id: "1", joke: "Why did the scarecrow win an award? Because he was outstanding in his field!", status: 200)
    }
}
