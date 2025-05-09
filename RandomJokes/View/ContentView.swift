//
//  ContentView.swift
//  RandomJokes
//
//  Created by wahid tariq on 09/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Random Jokes")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.fetchJokes()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
        }
        .task {
            viewModel.fetchJokes()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView("Loading...")
        case .loaded:
            ZStack {
                backgroundView
                textWithBackground
            }
        case .error(let error):
            ContentUnavailableView {
                Text("Oops, Something went wrong")
            } description: {
                Text(error.localizedDescription)
            } actions: {
                Button("Retry") {
                    viewModel.fetchJokes()
                }
            }
        }
    }
    
    var backgroundView: some View {
        Color.black.opacity(0.2)
            .ignoresSafeArea()
    }
    
    var textWithBackground: some View {
        Text(viewModel.joke.joke)
            .multilineTextAlignment(.center)
            .font(
                .system(
                    size: 20,
                    weight: .bold,
                    design: .monospaced
                )
            )
            .padding()
            .padding(.horizontal)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(.ultraThickMaterial)
                    .containerRelativeFrame([.vertical, .horizontal]) { size, axis in
                        switch axis {
                        case .horizontal:
                            return size * 0.9
                        case .vertical:
                            return size * 0.7
                        }
                    }
            )
    }
}

#Preview {
    ContentView()
}
