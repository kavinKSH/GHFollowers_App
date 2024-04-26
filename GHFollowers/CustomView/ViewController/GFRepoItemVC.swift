//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Kavin on 30/03/24.
//

import UIKit

protocol GFRepoItemDelegate: AnyObject {
    func didTapGetProfile(for users: Users)
}

class GFRepoItemVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemDelegate!
    
    init(user: Users, delegate: GFRepoItemDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRepoItems()
    }
    
    private func setRepoItems(){
        userListViewOne.set(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        userListViewTwo.set(itemInfoType: .gists, withCount: user.publicGists ?? 0)
        actionButton.set(title: "GitHub Profile", color: .systemPurple, systemImageName: "person")
    }
    
    override func actionButtonTapped() {
        super.actionButtonTapped()
        delegate?.didTapGetProfile(for: user)
    }
}
