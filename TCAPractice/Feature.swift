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
    
    let service: NumberFactService
    
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
                let fact = try await service.fetch(count)
                await send(.numberFactResponse(fact))
            }
        case .numberFactResponse(let fact):
            state.numberFactAlert = fact
            return .none
        }
    }
}
