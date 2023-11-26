//
//  VacancyInfoViewModel.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 27.11.2023.
//

import Foundation
import Combine

final class VacancyInfoViewModel: ObservableObject {
    @Published var vacancyID: String
    var vacancyInfo: CurrentValueSubject<VacancyModel?, Never> = CurrentValueSubject(nil)

    private var bag = Set<AnyCancellable>()

    init(vacancyID: String) {
        self.vacancyID = vacancyID
        getVacancyInfo()
    }

    private func getVacancyInfo() {
        $vacancyID
            .filter({ $0 != "" })
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .flatMap { (vacancyID) -> AnyPublisher<VacancyModel, Never> in
                API.getVacancyInfo(vacancyID: vacancyID)
                    .catch { (_) in
                        Just(VacancyModel(
                            id: "",
                            name: "",
                            salary: nil,
                            employer: nil,
                            snippet: nil,
                            description: "",
                            address: nil
                        ))
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [unowned self] (vacancyInfo) in
                self.vacancyInfo.send(vacancyInfo)
            }.store(in: &bag)
    }
}
