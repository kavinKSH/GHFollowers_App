//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//
import SafariServices
import UIKit

extension UIViewController {
    
    func presentGFAlert(title: String ,message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(alertTitle: title, message: message, buttontitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func checkProfileFromSafariVC(url: String) {
        guard let url = URL(string: url) else {
            presentGFAlert(title: "Invalid URL", message: "The url attached this user is Invalid", buttonTitle: "Ok")
            return
        }
        let safariVC = SFSafariViewController(url:url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
}
