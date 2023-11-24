//
//  VacancyInfoViewInput.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 24.11.2023.
//

import Foundation

protocol VacancyInfoViewInput: AnyObject {
    func updateView(vacancy: VacancyModel)
}
