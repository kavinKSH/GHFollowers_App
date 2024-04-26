//
//  FavoritesCell.swift
//  GHFollowers
//
//  Created by Kavin on 03/04/24.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    let avatormageView = GFImageView(frame: .zero)
    let UserNameLabel = GFTitleLabel(textAlienment: .left, font: 25)
    
    static let reuseID = "FavoritesCellID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubviews(avatormageView,UserNameLabel)
        accessoryType = .disclosureIndicator
        let padding:CGFloat = 12
        
        NSLayoutConstraint.activate([
            avatormageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatormageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatormageView.heightAnchor.constraint(equalToConstant: 60),
            avatormageView.widthAnchor.constraint(equalToConstant: 60),
            
            UserNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            UserNameLabel.leadingAnchor.constraint(equalTo: avatormageView.trailingAnchor, constant: padding),
            UserNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            UserNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateCellDatas(followers: Followers) {
        UserNameLabel.text = followers.login
        Task {
            let image = await NetworkManager.shared.downloadingImages(imageURL: followers.avatarUrl ?? "")
            avatormageView.image = image
        }
    }
}
