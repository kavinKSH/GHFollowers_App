//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView       = UIImageView()
    let userNameTextField   = GFTextField()
    let callToActionButton  = GFButton(color: .systemGreen, title: "Get Followers", systemImageName: "person.3.fill")
    
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isEnteredUserName: Bool {
        return userNameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,userNameTextField,callToActionButton)
        userNameTextField.delegate = self
        createKeyboardDismissTapGesture()
        configureUsernameTextFiled()
        configureCallToActionButton()
        configureTapOnView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        userNameTextField.text = ""
    }
    
    @objc func pushToFollowerListVC() {
        userNameTextField.resignFirstResponder()
        
        guard !userNameTextField.text!.isEmpty else {
            presentGFAlert(title: "Empty userName", message: "Please enter userName, we need to know who to looking for 😊.", buttonTitle: "Ok")
            return
        }
        let followersListVC = FollowersListVC(userName: userNameTextField.text ?? "")
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    //MARK: - Constraints
    
    func configureTapOnView() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func createKeyboardDismissTapGesture() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstrints: CGFloat = DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed ? 20 : 50
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstrints)
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureUsernameTextFiled() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushToFollowerListVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
}

//MARK: - UITextField-Delegate
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowerListVC()
        return true
    }
}
