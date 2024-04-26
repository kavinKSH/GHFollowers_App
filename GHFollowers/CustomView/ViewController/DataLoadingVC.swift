//
//  DataLoadingVC.swift
//  GHFollowers
//
//  Created by Kavin on 04/04/24.
//

import UIKit

class DataLoadingVC: UIViewController {
    
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLodingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicater = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicater)
        activityIndicater.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicater.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicater.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicater.startAnimating()
    }
    
    func stopLoadingView() {
        self.containerView.removeFromSuperview()
        self.containerView = nil
    }
    
    func showEmptyState(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
