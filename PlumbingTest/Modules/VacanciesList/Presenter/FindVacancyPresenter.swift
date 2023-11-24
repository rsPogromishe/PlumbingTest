//
//  FindVacancyPresenter.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 23.11.2023.
//

import Foundation
import Combine

class FindVacancyPresenter: FindVacancyPresenterProtocol {
    weak var view: FindVacancyViewInput?

    var vacancies = [VacancyModel]()
    private var bag = Set<AnyCancellable>()
    private var pageNumber = 0

    func getVacancy(searchText: String, pageNumber: Int) {
        if pageNumber == 0 {
            self.pageNumber = 0
        } else {
            self.pageNumber += pageNumber
        }
        API.getVacancies(searchText: searchText, pageNumber: pageNumber)
            .delay(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { result in
                print("RESULT GET VACANCY: \(result)")
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                print("RESPONSE GET VACANCY: \(response)")
                if self.pageNumber == 0 {
                    self.vacancies = response.items ?? [VacancyModel]()
                } else {
                    self.vacancies += response.items ?? [VacancyModel]()
                }
                self.view?.reloadData(isVacanciesEmpty: self.vacancies.isEmpty)
            }
            .store(in: &bag)
    }

    func removeAllVacancies() {
        vacancies.removeAll()
        self.view?.reloadData(isVacanciesEmpty: vacancies.isEmpty)
    }

    func openVacancyInfo(indexPath: Int) {
        let viewController = VacancyInfoAssemble.assembleVacancyInfoModule(vacancyID: vacancies[indexPath].id ?? "")
        self.view?.openVacancyInfo(viewController: viewController)
    }
}
