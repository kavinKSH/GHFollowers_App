//
//  GFButton.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String,systemImageName: String) {
        self.init(frame: .zero)
        set(title: title, color: color, systemImageName: systemImageName)
    }
    
    private func configure(){
        configuration = .tinted()
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(title: String, color: UIColor, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
        self.setTitle(title, for: .normal)
    }
}
