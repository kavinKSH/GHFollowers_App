//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Kavin on 05/04/24.
//

import UIKit

extension UITableView {
    func removeTableViewExcessCells(){
        tableFooterView?.frame = .zero
    }
}
