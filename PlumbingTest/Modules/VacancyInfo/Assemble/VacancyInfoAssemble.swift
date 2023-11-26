//
//  VacancyInfoAssemble.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 24.11.2023.
//

import UIKit

final class VacancyInfoAssemble {
    static func assembleVacancyInfoModule(vacancyID: String) -> UIViewController {
        let viewModel = VacancyInfoViewModel(vacancyID: vacancyID)
        let view = VacancyInfoViewController(viewModel: viewModel)
        return view
    }
}
