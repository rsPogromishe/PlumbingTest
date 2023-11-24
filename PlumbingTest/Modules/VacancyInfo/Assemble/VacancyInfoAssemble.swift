//
//  VacancyInfoAssemble.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 24.11.2023.
//

import UIKit

final class VacancyInfoAssemble {
    static func assembleVacancyInfoModule(vacancyID: String) -> UIViewController {
        let presenter = VacancyInfoPresenter(vacancyID: vacancyID)
        let view = VacancyInfoViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
