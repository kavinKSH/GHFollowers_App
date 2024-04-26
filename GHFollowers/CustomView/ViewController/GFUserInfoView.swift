//
//  GFUserInfoView.swift
//  GHFollowers
//
//  Created by Kavin on 30/03/24.
//

import UIKit

enum ItemInfoType { case repos,gists,following,followers }

class GFUserInfoView: UIView {  
    
    let systemImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlienment: .left, font: 16)
    let countLabel      = GFTitleLabel(textAlienment: .center, font: 16)

    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubviews(systemImageView,titleLabel,countLabel)
        
        systemImageView.tintColor   = .secondaryLabel
        systemImageView.contentMode = .scaleAspectFit
        systemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            systemImageView.topAnchor.constraint(equalTo: self.topAnchor),
            systemImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            systemImageView.heightAnchor.constraint(equalToConstant: 20),
            systemImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: systemImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: systemImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: systemImageView.bottomAnchor, constant: 5),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            systemImageView.image = Images.repos
            titleLabel.text = "Public Repos"
        case .gists:
            systemImageView.image = Images.gists
            titleLabel.text = "Public Gists"
        case .following:
            systemImageView.image = Images.following
            titleLabel.text = "Following"
        case .followers:
            systemImageView.image = Images.followers
            titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }
}
