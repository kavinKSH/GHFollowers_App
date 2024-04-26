//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Kavin on 30/03/24.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView       = UIStackView()
    let userListViewOne = GFUserInfoView()
    let userListViewTwo = GFUserInfoView()
    let actionButton    = GFButton()
    
    var user: Users!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateUI()
    }
    init(user: Users) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configure() {
        view.addSubviews(stackView,actionButton)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(userListViewOne)
        stackView.addArrangedSubview(userListViewTwo)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func actionButtonTapped() {
        
    }
}
