//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Kavin on 05/04/24.
//

import UIKit


extension UIView {
    
    func pinToViewEdges(_ view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addSubviews(_ views: UIView...){
        for view in views {
            self.addSubview(view)
        }
    }
}
