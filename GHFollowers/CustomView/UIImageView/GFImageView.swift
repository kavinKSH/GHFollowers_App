//
//  GFImageView.swift
//  GHFollowers
//
//  Created by Kavin on 27/03/24.
//

import UIKit

class GFImageView: UIImageView {
    
    let placeholder = Images.placeholder
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}
