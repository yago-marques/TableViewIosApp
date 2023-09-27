//
//  CellCompositor.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import UIKit

protocol TableViewCellViewModel {}

protocol TableViewCellBuilder: UITableViewCell {
    func configure(
        with viewModel: TableViewCellViewModel,
        and controller: TableViewCellBuilderController
    )
}

protocol TableViewCellBuilderController { }
