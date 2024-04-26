//
//  FollowersCell.swift
//  GHFollowers
//
//  Created by Kavin on 27/03/24.
//

import UIKit

class FollowersCell: UICollectionViewCell {
    
    let avatormageView = GFImageView(frame: .zero)
    let UserNameLabel = GFTitleLabel(textAlienment: .center, font: 16)
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(follwer: Followers) {
        UserNameLabel.text = follwer.login
        Task {
            
            guard let image = await NetworkManager.shared.downloadingImages(imageURL: follwer.avatarUrl ?? "") else {return}
            avatormageView.image = image
        }
    }
    
    private func configure() {
        let padding:CGFloat = 8
        addSubviews(avatormageView,UserNameLabel)
        
        NSLayoutConstraint.activate([
            avatormageView.topAnchor.constraint(equalTo: topAnchor, constant:padding),
            avatormageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatormageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatormageView.heightAnchor.constraint(equalTo: avatormageView.widthAnchor),
            
            UserNameLabel.topAnchor.constraint(equalTo: avatormageView.bottomAnchor, constant: 12),
            UserNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            UserNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            UserNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
