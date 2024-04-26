//
//  GHUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Kavin on 29/03/24.
//

import UIKit

class GHUserInfoHeaderVC: UIViewController {
    
    var userInfo: Users?
    
    let locationImageView       = UIImageView()
    let avatarImageView         = GFImageView(frame: .zero)
    let userNamelabel           = GFTitleLabel(textAlienment: .left, font: 30)
    let nameLabel               = GFsecoendaryLabel(font: 17)
    let locationLabel           = GFTitleLabel(textAlienment: .left, font: 17)
    let biolabel                = GFBodyLabel(textAlienment: .left)
    
    init(userInfo: Users ){
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        layoutUI()
        updateUIElements()
    }
    
    func updateUIElements() {
        userNamelabel.text          = userInfo?.login
        nameLabel.text              = userInfo?.name ?? ""
        locationLabel.text          = userInfo?.location ?? "No Location"
        biolabel.text               = userInfo?.bio
        locationImageView.image     = Images.logoImageView
        locationImageView.tintColor = .secondaryLabel
        downLoadImages()
        
    }
    
    func downLoadImages() {
        Task {
            let image = await NetworkManager.shared.downloadingImages(imageURL: userInfo?.avatarUrl ?? "")
            avatarImageView.image = image
        }
    }
    
    func addSubview() {
        view.addSubviews(avatarImageView,userNamelabel,nameLabel,locationImageView,
                         locationLabel,biolabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userNamelabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNamelabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            userNamelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNamelabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: locationImageView.topAnchor, constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            biolabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            biolabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 0),
            biolabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            biolabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
}

