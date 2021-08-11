//
//  MoviesApp.swift
//  Movies
//
//  Created by Davi Cabral de Oliveira on 19/05/21.
//

import ComposableArchitecture
import SwiftUI
import TMDBKit

@main
struct MoviesApp: App {
    
    init() {
        TMDBConfiguration.setup(withKey: "512c4e2722f82f30f20fdaa7671153a3", andLanguage: "en-US")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: MovieState(),
                    reducer: appReducer,
                    environment: MovieEnvironment()
                ))
        }
    }
}
