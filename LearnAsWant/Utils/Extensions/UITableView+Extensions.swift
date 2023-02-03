//
//  UITableView+Extensions.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

extension UITableView {

    func hideEmptyRows() {
        tableFooterView = UIView()
    }

    func hideSectionsSeparator() {
        separatorColor = backgroundColor
    }

    func removeTopInset() {
        contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }

    func fixInsets() {
        let zContentInsets = UIEdgeInsets.zero
        contentInset = zContentInsets
        scrollIndicatorInsets = zContentInsets
    }

    func reload(reloadCompleted: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            reloadCompleted()
        }
        self.reloadData()
        self.layoutIfNeeded()
        CATransaction.commit()
    }

    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }

    func removeTableHeaderViewWithAnimation() {
        beginUpdates()
        let newFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.tableHeaderView?.frame = newFrame
            self?.tableHeaderView = nil
        }
        endUpdates()
    }

    func register(nibModels: [PTableViewCellAnyModel.Type]) {
        for model in nibModels {
            let identifier = String(describing: model.cellAnyType)
            let nib = UINib(nibName: identifier, bundle: nil)
            register(nib, forCellReuseIdentifier: identifier)
        }
    }

    func register(models: [PTableViewCellAnyModel.Type]) {
        for model in models {
            let identifier = String(describing: model.cellAnyType)
            register(model.cellAnyType, forCellReuseIdentifier: identifier)
        }
    }

    func register<Cell: UITableViewCell>(cellClass: Cell.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell(withModel model: PTableViewCellAnyModel, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: type(of: model).cellAnyType)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        model.configureAny(cell: cell)
        return cell
    }

    func dequeueReusableCell<CellModel: PTableViewCellModel>(
        withModel model: CellModel,
        for indexPath: IndexPath
    ) -> CellModel.CellType {
        let identifier = String(describing: CellModel.CellType.self)
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CellModel.CellType
        model.configure(cell: cell)
        return cell
    }

    func dequeueReusableCell<Cell: UITableViewCell>(
        cellClass: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! Cell
    }

    func disableContentInsetAdjustmentBehavior() {
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }

    func setTableViewManager(_ tableViewManager: UITableViewDataSource & UITableViewDelegate) {
        delegate = tableViewManager
        dataSource = tableViewManager
    }
}
