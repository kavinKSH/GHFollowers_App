//
//  GFFollowersItemVC.swift
//  GHFollowers
//
//  Created by Kavin on 30/03/24.
//

import UIKit

protocol GFFollowersItemDelegate: AnyObject{
    func didTapGetFollowers(for users: Users)
}

class GFFollowersItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowersItemDelegate!
    
    init(user: Users, delegate: GFFollowersItemDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFollowersItems()
    }
    
    private func setFollowersItems() {
        userListViewOne.set(itemInfoType: .followers, withCount: user.followers ?? 0)
        userListViewTwo.set(itemInfoType: .following, withCount: user.following ?? 0)
        actionButton.set(title: "Get Followers", color: .systemGreen, systemImageName: "person.3.fill")
    }
    
    @objc override func actionButtonTapped() {
         super.actionButtonTapped()
        delegate?.didTapGetFollowers(for: user)
    }
}

