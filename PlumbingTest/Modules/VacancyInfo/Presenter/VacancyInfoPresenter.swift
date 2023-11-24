//
//  VacancyInfoPresenter.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 24.11.2023.
//

import Foundation
import Combine

class VacancyInfoPresenter: VacancyInfoPresenterProtocol {
    weak var view: VacancyInfoViewInput?

    private var vacancyID: String
    private var bag = Set<AnyCancellable>()

    init(vacancyID: String) {
        self.vacancyID = vacancyID
    }

    func getVacancyInfo() {
        API.getVacancyInfo(vacancyID: vacancyID)
            .sink { result in
                print("RESULT GET VACANCY INFO: \(result)")
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                print("RESPONSE GET VACANCY INFO: \(response)")
                self.view?.updateView(vacancy: response)
            }
            .store(in: &bag)
    }
}
