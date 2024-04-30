//
//  TableScreenView.swift
//  Energise
//
//  Created by Andrew Kasilov on 30.04.2024.
//

import Foundation
import SnapKit
import UIKit

protocol TableScreenViewProtocol: AnyObject {
    func subviews(action: TableScreenViewAction)
}

enum TableScreenViewAction {
    case rate
    case share
    case contact
}

final class TableScreenView: UIView {
    // - MARK: views
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(TableViewCell.self)
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .lightGray
        table.separatorStyle = .none
        return table
    }()

    // - MARK: internal
    weak var delegate: TableScreenViewProtocol?

    // - MARK: private
    private let tableData = [NSLocalizedString("rate", comment: ""), NSLocalizedString("share", comment: ""), NSLocalizedString("contact", comment: "")]

    // - MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// - MARK: private extension
private extension TableScreenView {
    func setupLayout() {
        addSubview(tableView) {
            $0.top.bottom.equalToSuperview().offset(200)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}

// - MARK: UITableViewDataSource
extension TableScreenView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let title = tableData[indexPath.row]
        cell.setupCell(title: title)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// - MARK: UITableViewDelegate
extension TableScreenView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            delegate?.subviews(action: .rate)
        case 1:
            delegate?.subviews(action: .share)
        case 2:
            delegate?.subviews(action: .contact)
        default:
            break
        }
    }
}
