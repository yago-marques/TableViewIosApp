//
//  TableDataSource.swift
//  TableViewApp
//
//  Created by Yago Marques on 13/07/23.
//

import Foundation

struct TableDataSource {
    let sections: [Section]
}

struct Section {
    let title: String?
    let components: [Component]
}

struct Component {
    let viewModel: TableViewCellViewModel
    let builder: TableViewCellBuilder.Type
}
