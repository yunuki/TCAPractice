//
//  Service.swift
//  TCAPractice
//
//  Created by 윤재욱 on 2023/09/02.
//

import Foundation

protocol NumberFactService {
    func fetch(_ number: Int) async throws -> String
}

struct DefaultNumberFactService: NumberFactService {
    func fetch(_ number: Int) async throws -> String {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
        return String(decoding: data, as: UTF8.self)
    }
}
