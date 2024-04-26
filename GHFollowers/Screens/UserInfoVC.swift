//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Kavin on 29/03/24.
//

import UIKit

protocol userInfoDelegate: AnyObject {
    func getSelectedUserFollowerList(userName: String)
}

class UserInfoVC: DataLoadingVC {
    
    let dateLabel           = GFBodyLabel(textAlienment: .center)
    var scrollView          = UIScrollView()
    let contentView         = UIView()
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    
    var itemArray: [UIView] = []
    var userName: String!
    
    weak var delegate: userInfoDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurenavigationItems()
        downloadingUsersData()
        layoutUI()
        configureScrollView()
    }
    
    func downloadingUsersData() {
        showLodingView()
        Task {
            do {
                let users = try await NetworkManager.shared.getUsers(userName: userName)
                configureUI(for: users)
                stopLoadingView()
            }catch {
                guard let gferror = error as? GFError else { return }
                presentGFAlert(title: "Error", message: gferror.rawValue, buttonTitle: "Ok")
                stopLoadingView()
            }
        }
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.pinToViewEdges(view)
        contentView.pinToViewEdges(scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800)
        ])
    }
    
    func configurenavigationItems(){
        title = userName
        view.backgroundColor = .systemBackground
        let doneButtom = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButtom
    }
    
    func add(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let height:CGFloat   = 140
        headerView.backgroundColor = .systemBackground
        
        itemArray = [headerView, itemViewOne,itemViewTwo, dateLabel]
        for itemView in itemArray {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: height),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: height),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureUI(for userInfo : Users) {
        self.add(childVC: GHUserInfoHeaderVC(userInfo: userInfo), containerView: self.headerView)
        let repoVC = GFRepoItemVC(user: userInfo, delegate: self)
        let followersVC = GFFollowersItemVC(user: userInfo, delegate: self)
        self.add(childVC: repoVC, containerView: self.itemViewOne)
        self.add(childVC: followersVC, containerView: self.itemViewTwo)
        let date = userInfo.createdAt.convertDateFormet()
        self.dateLabel.text = ("GitHub since \(date)")
    }
}

extension UserInfoVC: GFRepoItemDelegate, GFFollowersItemDelegate {
    
    func didTapGetFollowers(for users: Users) {
        delegate?.getSelectedUserFollowerList(userName: users.login)
        dismissVC()
    }
    
    func didTapGetProfile(for users: Users) {
        checkProfileFromSafariVC(url: users.htmlUrl)
    }
}



