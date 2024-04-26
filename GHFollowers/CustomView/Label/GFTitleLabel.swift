//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class GFTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlienment: NSTextAlignment, font: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlienment
        self.font = UIFont.systemFont(ofSize: font, weight: .bold)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 12.0
        lineBreakMode = .byTruncatingTail
        adjustsFontForContentSizeCategory = true
        textColor = .label
    }
}
