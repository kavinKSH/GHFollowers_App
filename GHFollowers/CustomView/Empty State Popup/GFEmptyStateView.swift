//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Kavin on 28/03/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlienment: .center, font: 26)
    let imagelogo    = GFImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        messageLabelConstraint()
        imageLogoViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        self.messageLabel.text = message
    }
    
    private func imageLogoViewConstraints() {
        addSubviews(imagelogo)
        messageLabel.textColor = .secondaryLabel
        imagelogo.image = Images.emptyStateLogoImage
        let imageLogoBottomConstraint: CGFloat = DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed ? 60 : 40
        
        NSLayoutConstraint.activate([
            imagelogo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imagelogo.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imagelogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imagelogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: imageLogoBottomConstraint)
        ])
    }
    
    func messageLabelConstraint() {
        addSubviews(messageLabel)
        messageLabel.numberOfLines = 3
        
        let centerXAncherConstanint:CGFloat = DeviceTypes.isIphoneSE || DeviceTypes.isIphone8PlusZoomed ? -100 : -150
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerXAncherConstanint),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

