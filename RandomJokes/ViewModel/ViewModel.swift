//
//  ViewModel.swift
//  RandomJokes
//
//  Created by wahid tariq on 09/05/25.
//

import Combine
import SwiftUI

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var joke: Joke = .example
    @Published var viewState: ViewState = .loading
    private var cancellables = Set<AnyCancellable>()
    
    func fetchJokes() {
        viewState = .loading
        guard let url = URL(string: "https://icanhazdadjoke.com") else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Joke.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    viewState = .loaded
                    break
                case .failure(let error):
                    viewState = .error(error)
                }
            } receiveValue: { joke in
                self.joke = joke
            }
            .store(in: &cancellables)
    }
}
