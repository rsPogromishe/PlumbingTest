//
//  VacancyInfoViewController.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 24.11.2023.
//

import UIKit
import Combine

class VacancyInfoViewController: UIViewController {
    private var presenter: VacancyInfoPresenterProtocol

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var vacancyDescLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private lazy var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.text = "Адрес:"
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    init(presenter: VacancyInfoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        presenter.getVacancyInfo()
    }
}

// MARK: - VacancyInfoViewInput

extension VacancyInfoViewController: VacancyInfoViewInput {
    func updateView(vacancy: VacancyModel) {
        vacancyNameLabel.text = vacancy.name ?? ""
        var salaryText = "От \(vacancy.salary?.from ?? 0)"
        if (vacancy.salary?.to ?? 0) != 0 {
            salaryText += " до \(vacancy.salary?.to ?? 0) \(vacancy.salary?.currency ?? "")"
        } else {
            salaryText += " \(vacancy.salary?.currency ?? "")"
        }
        salaryLabel.text = (vacancy.salary?.from ?? 0) == 0 ? "" : salaryText
        vacancyDescLabel.attributedText = vacancy.description?.htmlAttributedString() ?? NSAttributedString()
        addressLabel.text = vacancy.address?.raw ?? ""
    }
}

// MARK: - SetupUI

extension VacancyInfoViewController {
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(vacancyNameLabel)
        scrollView.addSubview(salaryLabel)
        scrollView.addSubview(vacancyDescLabel)
        scrollView.addSubview(addressTitleLabel)
        scrollView.addSubview(addressLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),

            vacancyNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            vacancyNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            vacancyNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            salaryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 10),
            salaryLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: vacancyNameLabel.trailingAnchor),

            vacancyDescLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            vacancyDescLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 10),
            vacancyDescLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            addressTitleLabel.topAnchor.constraint(equalTo: vacancyDescLabel.bottomAnchor, constant: 10),
            addressTitleLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),

            addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 6),
            addressLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            addressLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}
