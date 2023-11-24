//
//  API.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import Foundation
import Combine

enum API {
    static private let agent = NetworkService()
    static private let base = URL(string: "https://api.hh.ru")!
}

extension API {
    static func getVacancies(searchText: String, pageNumber: Int) -> AnyPublisher<SearchVacanciesModel, Error> {
        let url = base.appendingPathComponent("/vacancies")
        let items = [
            URLQueryItem(name: "text", value: "\(searchText)"),
            URLQueryItem(name: "per_page", value: "20"),
            URLQueryItem(name: "page", value: "\(pageNumber)")
        ]
        return agent.run(method: HttpMethod.get.rawValue, url: url, parameters: items, headers: nil, body: nil)
    }

    static func getVacancyInfo(vacancyID: String) -> AnyPublisher<VacancyModel, Error> {
        let url = base.appendingPathComponent("/vacancies/\(vacancyID)")
        return agent.run(method: HttpMethod.get.rawValue, url: url, headers: nil, body: nil)
    }
}
