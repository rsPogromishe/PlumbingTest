//
//  UITextField.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 25.11.2023.
//

import UIKit
import Combine

extension UITextField {
    var publisher: Publishers.TextFieldPublisher {
        return Publishers.TextFieldPublisher(textField: self)
    }
}
