//
//  SearchBar.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import UIKit

class SearchBar: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        placeholder = "Поиск вакансий"
        font = .systemFont(ofSize: 14)
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        autocorrectionType = .no

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.height))
        leftViewMode = .always
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: frame.height))
        let imageView = UIImageView()
        let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
        imageView.image = magnifyingGlassImage
        imageView.frame = CGRect(x: 0, y: -8, width: 18, height: 18)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.gray
        view.addSubview(imageView)
        rightViewMode = .always
        rightView = view
    }
}
