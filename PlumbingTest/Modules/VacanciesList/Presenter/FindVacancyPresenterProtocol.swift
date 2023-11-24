//
//  FindVacancyPresenterProtocol.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 23.11.2023.
//

import Foundation

protocol FindVacancyPresenterProtocol {
    var vacancies: [VacancyModel] { get set }

    func getVacancy(searchText: String, pageNumber: Int)
    func removeAllVacancies()
    func openVacancyInfo(indexPath: Int)
}
