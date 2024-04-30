//
//  TableViewCell.swift
//  Energise
//
//  Created by Andrew Kasilov on 30.04.2024.
//

import UIKit

final class TableViewCell: UITableViewCell {
    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    func setupCell(title: String) {
        label.text = title
    }
}

// - MARK: private extension
private extension TableViewCell {
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .lightGray
        label.backgroundColor = .orange
        label.text = "Label text"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
    }

    func setupLayout() {
        contentView.addSubview(label) {
            $0.edges.equalToSuperview()
        }
    }
}
