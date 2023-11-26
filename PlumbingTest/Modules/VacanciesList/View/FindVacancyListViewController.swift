//
//  ViewController.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import UIKit
import Combine

class FindVacancyListViewController: UIViewController {
    private let viewModel = FindVacancyViewModel()
    private var bag = Set<AnyCancellable>()

    private lazy var searchBar: UITextField = {
        let search = SearchBar()
        search.delegate = self
        search.translatesAutoresizingMaskIntoConstraints = false
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Вакансии hh.ru"
        setupUI()
        bindingTextField()
        bindingTableView()
    }

    func bindingTextField() {
        searchBar.publisher
            .assign(to: \.searchText, on: viewModel)
            .store(in: &bag)
    }

    func bindingTableView() {
        viewModel.vacancies
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            .store(in: &bag)

        viewModel.$searchText
            .sink { [weak self] value in
                guard let self = self else { return }
                self.tableView.isHidden = value.count < 1
                self.emptyListLabel.isHidden = value.count >= 1
                if value == "" { self.viewModel.vacancies.value.items?.removeAll() }
            }
            .store(in: &bag)
    }
}

// MARK: TableView Delegate/DataSource

extension FindVacancyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.vacancies.value.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: VacanciesListTableViewCell.identifier,
            for: indexPath
        ) as? VacanciesListTableViewCell,
           let vacancyInfo = viewModel.vacancies.value.items?[indexPath.row] {
            cell.configure(vacancy: vacancyInfo)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = VacancyInfoAssemble.assembleVacancyInfoModule(
            vacancyID: viewModel.vacancies.value.items?[indexPath.row].id ?? ""
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.pushViewController(viewController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.vacancies.value.items?.count ?? 0) - 5 {
            self.viewModel.pageNumber += 1
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
