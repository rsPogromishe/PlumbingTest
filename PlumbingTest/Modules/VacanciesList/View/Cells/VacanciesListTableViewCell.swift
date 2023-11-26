//
//  VacanciesListTableViewCell.swift
//  PlumbingTest
//
//  Created by Снытин Ростислав on 22.11.2023.
//

import UIKit
import SDWebImage

class VacanciesListTableViewCell: UITableViewCell {
    static let identifier = "vacanciesListTableViewCell"

    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 50
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        return view
    }()

    private lazy var vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var nameOfEmployerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var requirementTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.text = "Требования:"
        return label
    }()

    private lazy var requirementLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var responsibilityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.text = "Обязанности:"
        return label
    }()

    private lazy var responsibilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            UIView.animate(
                withDuration: 0.2,
                animations: {
                    self.transform = CGAffineTransform(scaleX: 0.87, y: 0.87)
                },
                completion: { _ in
                    UIView.animate(withDuration: 0.2) {
                        self.transform = .identity
                    }
                }
            )
        }
    }

    func configure(vacancy: VacancyModel) {
        avatarImageView.sd_setImage(
            with: URL(string: vacancy.employer?.logoUrls?.original ?? ""),
            placeholderImage: UIImage(systemName: "person.crop.circle")
        )
        vacancyNameLabel.text = vacancy.name ?? ""
        var salaryText = "От \(vacancy.salary?.from ?? 0)"
        if (vacancy.salary?.to ?? 0) != 0 {
            salaryText += " до \(vacancy.salary?.to ?? 0) \(vacancy.salary?.currency ?? "")"
        } else {
            salaryText += " \(vacancy.salary?.currency ?? "")"
        }
        salaryLabel.text = (vacancy.salary?.from ?? 0) == 0 ? "" : salaryText
        nameOfEmployerLabel.text = vacancy.employer?.name ?? ""
        requirementLabel.attributedText = vacancy.snippet?.requirement?.htmlAttributedString() ?? NSAttributedString()
        responsibilityLabel.attributedText =
            vacancy.snippet?.responsibility?.htmlAttributedString() ?? NSAttributedString()
    }
}

// MARK: - SetupUI

extension VacanciesListTableViewCell {
    private func setupUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(vacancyNameLabel)
        contentView.addSubview(salaryLabel)
        contentView.addSubview(nameOfEmployerLabel)
        contentView.addSubview(requirementTitleLabel)
        contentView.addSubview(requirementLabel)
        contentView.addSubview(responsibilityTitleLabel)
        contentView.addSubview(responsibilityLabel)
        contentView.addSubview(separatorLine)

        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            vacancyNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            vacancyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            vacancyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            salaryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 6),
            salaryLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            salaryLabel.trailingAnchor.constraint(equalTo: vacancyNameLabel.trailingAnchor),

            nameOfEmployerLabel.topAnchor.constraint(equalTo: salaryLabel.bottomAnchor, constant: 10),
            nameOfEmployerLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            nameOfEmployerLabel.trailingAnchor.constraint(equalTo: vacancyNameLabel.trailingAnchor),

            requirementTitleLabel.topAnchor.constraint(equalTo: nameOfEmployerLabel.bottomAnchor, constant: 6),
            requirementTitleLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),

            requirementLabel.topAnchor.constraint(equalTo: requirementTitleLabel.bottomAnchor, constant: 4),
            requirementLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            requirementLabel.trailingAnchor.constraint(equalTo: vacancyNameLabel.trailingAnchor),

            responsibilityTitleLabel.topAnchor.constraint(equalTo: requirementLabel.bottomAnchor, constant: 6),
            responsibilityTitleLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),

            responsibilityLabel.topAnchor.constraint(equalTo: responsibilityTitleLabel.bottomAnchor, constant: 6),
            responsibilityLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            responsibilityLabel.trailingAnchor.constraint(equalTo: vacancyNameLabel.trailingAnchor),

            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorLine.topAnchor.constraint(equalTo: responsibilityLabel.bottomAnchor, constant: 10),
            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
