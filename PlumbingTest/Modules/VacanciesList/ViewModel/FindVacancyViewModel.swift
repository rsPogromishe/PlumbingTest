//
//  FindVacancyViewModel.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 25.11.2023.
//

import Combine
import Foundation

final class FindVacancyViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var pageNumber = 0
    var vacancies = CurrentValueSubject<SearchVacanciesModel, Never>(SearchVacanciesModel(items: [VacancyModel]()))

    private var bag = Set<AnyCancellable>()

    init() {
        getVacancies()
    }

    func getVacancies() {
        $searchText
            .filter({ $0 != "" && $0.count >= 3 })
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .flatMap { (searchText) -> AnyPublisher<SearchVacanciesModel, Never> in
                API.getVacancies(searchText: searchText, pageNumber: self.pageNumber)
                    .catch { (_) in
                        Just(SearchVacanciesModel(items: [VacancyModel]()))
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [unowned self] (fetchedVacancies) in
                self.vacancies.send(fetchedVacancies)
            }.store(in: &bag)

        $pageNumber
            .filter({ $0 != 0 })
            .removeDuplicates()
            .flatMap { (pageNumber) -> AnyPublisher<SearchVacanciesModel, Never> in
                API.getVacancies(searchText: self.searchText, pageNumber: pageNumber)
                    .catch { (_) in
                        Just(SearchVacanciesModel(items: [VacancyModel]()))
                    }
                    .eraseToAnyPublisher()
            }
            .sink { [unowned self] (fetchedVacancies) in
                self.vacancies.value.items? += fetchedVacancies.items ?? [VacancyModel]()
            }.store(in: &bag)
    }
}
