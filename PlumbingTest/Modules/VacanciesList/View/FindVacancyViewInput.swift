//
//  FindVacancyViewInput.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 23.11.2023.
//

import UIKit

protocol FindVacancyViewInput: AnyObject {
    func reloadData(isVacanciesEmpty: Bool)
    func openVacancyInfo(viewController: UIViewController)
}
