//
//  TCAPracticeApp.swift
//  TCAPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: StoreOf<Feature>(initialState: Feature.State(), reducer: {
                    Feature()
                })
            )
        }
    }
}
