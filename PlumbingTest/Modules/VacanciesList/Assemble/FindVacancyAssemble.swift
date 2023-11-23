//
//  FindVacancyAssemble.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 23.11.2023.
//

import UIKit

final class FindVacancyAssemble {
    static func assembleFindVacancyModule() -> UIViewController {
        let presenter = FindVacancyPresenter()
        let view = FindVacancyListViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
