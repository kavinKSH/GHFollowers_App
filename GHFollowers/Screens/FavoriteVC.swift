//
//  FavoriteVC.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class FavoriteVC: DataLoadingVC {
    
    let tableView = UITableView()
    
    var favoriteListArr: [Followers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retriveFavoriteDatas()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favoriteListArr.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "No favorites"
            config.secondaryText = "No favorites list added, please find the favorited persons"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
    }
    
    func retriveFavoriteDatas() {
        showLodingView()
        PresistenceManager.retriveFavorites { result in
            switch result {
            case .success(let favorites):
                self.updateFavoritesUI(with: favorites)
                
            case .failure(let error):
                self.presentGFAlert(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func updateFavoritesUI(with favorites: [Followers]) {
        self.favoriteListArr = favorites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
        }
        self.tableView.removeTableViewExcessCells()
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        let favorites = favoriteListArr[indexPath.row]
        cell.updateCellDatas(followers: favorites)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorites = favoriteListArr[indexPath.row]
        let destVC = FollowersListVC(userName: favorites.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PresistenceManager.updateFavorite(favorites: favoriteListArr[indexPath.row], updateType: .remove) { [weak self] error in
            guard let self else {return}
            guard let error  else {
                self.favoriteListArr.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                self.setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
