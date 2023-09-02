//
//  Feature.swift
//  TCAPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import Foundation
import ComposableArchitecture

struct Feature: Reducer {
    struct State: Equatable {
        var count: Int = 0
        var numberFactAlert: String?
    }
    enum Action: Equatable {
        case factAlertDismissed
        case decrementButtonTapped
        case incrementButtonTapped
        case numberFactButtonTapped
        case numberFactResponse(String)
    }
    
    @Dependency(\.numberFact) var numberFact
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            return .none
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        case .numberFactButtonTapped:
            return .run { [count = state.count] send in
                let fact = try await self.numberFact.fetch(count)
                await send(.numberFactResponse(fact))
            }
        case .numberFactResponse(let fact):
            state.numberFactAlert = fact
            return .none
        }
    }
}

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static var liveValue = Self { number in
        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
        return String(decoding: data, as: UTF8.self)
    }
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
