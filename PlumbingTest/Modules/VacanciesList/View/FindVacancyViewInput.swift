//
//  FindVacancyViewInput.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 23.11.2023.
//

import Foundation

protocol FindVacancyViewInput: AnyObject {
    func reloadData(isVacanciesEmpty: Bool)
}
