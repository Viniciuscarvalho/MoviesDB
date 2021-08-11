//
//  ContentView.swift
//  Movies
//
//  Created by Davi Cabral de Oliveira on 19/05/21.
//

import ComposableArchitecture
import SwiftUI
import TMDBKit

extension TMDBMovie: Identifiable {}

struct MovieState: Equatable {
    var movies: [TMDBMovie] = []
}

enum MovieAction {
    case loading(Bool)
    case onAppear
    case fetch
    case show([TMDBMovie])
    case movieResponse(Result<[TMDBMovie], Error>)
}

struct MovieEnvironment {
    let fetcher: TMDBFetcher = TMDBFetcher()
}

let appReducer = Reducer<MovieState, MovieAction, MovieEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        // Usando o Effect.future é possível utilizar closures com @escaping dentro do reducer
//        return Effect.future { result in
//            environment.fetcher.fetchMovies { movieResult in
//                let movies = try! movieResult.get()
//                result(.success(MovieAction.show(movies)))
//            }
//        }
        
        // Merge dispara 2 Effect em paralelo
        return .merge( [
            Effect(value: MovieAction.loading(true)),
            Effect(value: MovieAction.fetch)
        ]
        )
    case .fetch:
        return environment.fetcher.fetchMovies()
            .catchToEffect()
            .map(MovieAction.movieResponse)
    case .movieResponse(let result):
        let movies = try! result.get()
        
        //Lança eventos de forma sequencial
        return .concatenate([
            Effect(value: .loading(false)),
            Effect(value: .show(movies))
        ])
    case .loading(let isLoading):
        print("isLoading \(isLoading)")
        return .none
    case .show(let movies):
        state.movies = movies
        return .none
    }
}

struct ContentView: View {
    let store: Store<MovieState, MovieAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                List(viewStore.movies) { movie in
                    Text(movie.originalTitle)
                }.navigationTitle("Movies")
            }
            .onAppear(perform: {
                viewStore.send(.onAppear)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: MovieState(),
                reducer: appReducer,
                environment: MovieEnvironment()
            )
        )
    }
}
