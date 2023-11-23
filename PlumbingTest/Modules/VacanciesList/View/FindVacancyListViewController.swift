//
//  ViewController.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import UIKit
import Combine

class FindVacancyListViewController: UIViewController {
    private var presenter: FindVacancyPresenterProtocol

    private lazy var searchBar: UITextField = {
        let search = SearchBar()
        search.delegate = self
        search.translatesAutoresizingMaskIntoConstraints = false
        search.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return search
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(
            VacanciesListTableViewCell.self,
            forCellReuseIdentifier: VacanciesListTableViewCell.identifier
        )
        tableView.isHidden = true
        return tableView
    }()

    private lazy var emptyListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите в поиск название\n и появится список вакансий"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    init(presenter: FindVacancyPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Вакансии hh.ru"
        setupUI()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 >= 3 {
            presenter.getVacancy(searchText: textField.text ?? "", pageNumber: 0)
        } else if textField.text?.isEmpty == true {
            presenter.removeAllVacancies()
        }
    }
}

// MARK: FindVacancyViewInput

extension FindVacancyListViewController: FindVacancyViewInput {
    func reloadData(isVacanciesEmpty: Bool) {
        self.tableView.reloadData()
        tableView.isHidden = isVacanciesEmpty
        emptyListLabel.isHidden = !isVacanciesEmpty
    }
}

// MARK: TableView Delegate/DataSource

extension FindVacancyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.vacancies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: VacanciesListTableViewCell.identifier,
            for: indexPath
        ) as? VacanciesListTableViewCell {
            cell.configure(vacancy: presenter.vacancies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.presenter.vacancies.count - 5 {
            presenter.getVacancy(searchText: searchBar.text ?? "", pageNumber: 1)
        }
    }
}

// MARK: - SearchBar Delegate

extension FindVacancyListViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if range.location == 0 && string == " " {
            return false
        }
        return true
    }
}

// MARK: - SetupUI

extension FindVacancyListViewController {
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(emptyListLabel)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyListLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyListLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
