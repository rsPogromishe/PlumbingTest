//
//  String.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import UIKit

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ) else { return nil }
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let string = NSAttributedString(string: html.string, attributes: attribute as [NSAttributedString.Key: Any])
        return string
    }
}
