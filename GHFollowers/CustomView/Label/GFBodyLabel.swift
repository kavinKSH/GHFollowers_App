//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlienment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlienment
    }
    
    private func configure() {
        adjustsFontSizeToFitWidth         = true
        minimumScaleFactor                = 0.75
        lineBreakMode                     = .byWordWrapping
        font                              = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        textColor                         = .secondaryLabel
        numberOfLines                     = 3
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
