//
//  ContentView.swift
//  TCAPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: StoreOf<Feature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped) }
                    Text("\(viewStore.count)")
                    Button("+") { viewStore.send(.incrementButtonTapped) }
                }
                
                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
            }
            .alert(viewStore.numberFactAlert ?? "",
                   isPresented: viewStore.binding(get: { $0.numberFactAlert != nil },
                                                  send: .factAlertDismissed),
                   actions: {})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: StoreOf<Feature>(initialState: Feature.State(), reducer: {
                Feature(service: DefaultNumberFactService())
            })
        )
    }
}
