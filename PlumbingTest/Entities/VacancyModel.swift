//
//  VacancyModel.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import Foundation

struct VacancyModel: Codable {
    let id: String?
    let name: String?
    let salary: Salary?
    let employer: Employer?
    let snippet: Snippet?
}

// MARK: - Employer

struct Employer: Codable {
    let name: String?
    let logoUrls: LogoUrls?

    enum CodingKeys: String, CodingKey {
        case name
        case logoUrls = "logo_urls"
    }
}

// MARK: - LogoUrls

struct LogoUrls: Codable {
    let the90, the240: String?
    let original: String?

    enum CodingKeys: String, CodingKey {
        case the90 = "90"
        case the240 = "240"
        case original
    }
}

// MARK: - Salary
struct Salary: Codable {
    let from, to: Int?
    let currency: String?
}

// MARK: - Snippet
struct Snippet: Codable {
    let requirement: String?
    let responsibility: String?
}
