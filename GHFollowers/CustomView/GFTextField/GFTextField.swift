//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius          = 10
        layer.borderColor           = UIColor.systemGray4.cgColor
        layer.borderWidth           = 2
        text                        = "SAllen0400"
        tintColor                   = .label
        textColor                   = .label
        textAlignment               = .center
        placeholder                 = "Enter a username"
        minimumFontSize             = 12
        clearButtonMode             = .whileEditing
        adjustsFontSizeToFitWidth   = true
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        autocorrectionType          = .no
        returnKeyType               = .go
    }
}
