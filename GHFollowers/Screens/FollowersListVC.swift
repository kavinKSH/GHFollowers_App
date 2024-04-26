//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Kavin on 25/03/24.
//

import UIKit

class FollowersListVC: DataLoadingVC {
    
    enum Section { case main }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Followers>!
    
    var userName: String!
    var page:Int                            = 1
    var hasMoreFollowers: Bool              = true
    var isSearching: Bool                   = false
    var isLoadingMoreFollowers:Bool         = false
    var followers           :[Followers]    = []
    var filteredFollowers   :[Followers]    = []
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
        title = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configurefollowersCollectionView()
        getFollowersData(userName: userName, page: page)
        configureDatasource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(updateFavoritesVC))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if followers.isEmpty && !isLoadingMoreFollowers {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "person.slash")
            config.text = "No Followers"
            config.secondaryText = "This user dosen't have any follower,let's go and follow them 😊"
            contentUnavailableConfiguration = config
        } else if isSearching && filteredFollowers.isEmpty {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        }else {
            contentUnavailableConfiguration = nil
        }
    }
    
    fileprivate func getFollowersData(userName: String, page: Int) {
        showLodingView()
        isLoadingMoreFollowers = true
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowersList(endpoints: .getFollowers(userName: userName, page: page))
                updateFollowersUI(follower: followers)
                stopLoadingView()
                self.isLoadingMoreFollowers = false

            }catch {
                guard let gfError = error as? GFError else { return }
                presentGFAlert(title: "Invalid Users", message: gfError.rawValue, buttonTitle: "Ok")
                stopLoadingView()
                isLoadingMoreFollowers = false
            }
        }
    }
    
    private func updateFollowersUI(follower: [Followers]){
        if follower.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: follower)
        self.updateSnapshot(of: self.followers)
        DispatchQueue.main.async {
            self.setNeedsUpdateContentUnavailableConfiguration()
        }
    }

    
    @objc func updateFavoritesVC() {
        showLodingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUsers(userName: userName)
                let favorite = Followers(login: user.login, avatarUrl: user.avatarUrl)
                stopLoadingView()
                addUserFavorites(with: favorite)
            }catch {
                guard let gferror = error as? GFError else { return }
                presentGFAlert(title: "Error", message: gferror.rawValue, buttonTitle: "Ok")
                stopLoadingView()
            }
        }
    }
    
    private func addUserFavorites(with favorite: Followers) {
        PresistenceManager.updateFavorite(favorites: favorite, updateType: .add) { error in
            guard let error = error else {
                self.presentGFAlert(title: "Success", message: "Successfully added to your favorites List", buttonTitle: "Keep Going 💐")
                return
            }
            self.presentGFAlert(title: "Error", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    func configurefollowersCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view))
        view.addSubviews(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.identifier)
    }
    
    func configureDatasource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Followers>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.identifier, for: indexPath) as? FollowersCell else {
                return UICollectionViewCell()
            }
            cell.setCell(follwer: follower)
            return cell
        })
    }
    
    func updateSnapshot(of follower: [Followers]) {
        var snopShot = NSDiffableDataSourceSnapshot<Section, Followers>()
        snopShot.appendSections([.main])
        snopShot.appendItems(follower)
        DispatchQueue.main.async {
            self.dataSource?.apply(snopShot, animatingDifferences: true)
        }
    }
}

//MARK: - Collection View Delegate

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers || !isLoadingMoreFollowers else { return }
            page += 1
            self.getFollowersData(userName: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredFollowers : followers
        let followersInfo   = activeArray[indexPath.item]
        let infoVC          = UserInfoVC()
        infoVC.userName     = followersInfo.login
        infoVC.delegate     = self
        let navController   = UINavigationController(rootViewController: infoVC)
        present(navController, animated: true)
    }
}

extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterUsers = searchController.searchBar.text, !filterUsers.isEmpty else {
            filteredFollowers.removeAll()
            isSearching = false
            updateSnapshot(of: followers)
            return
        }
        isSearching = true
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filterUsers.lowercased())}
        updateSnapshot(of: filteredFollowers)
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

extension FollowersListVC: userInfoDelegate {
    
    func getSelectedUserFollowerList(userName: String) {
        self.userName = userName
        title = userName
        page = 1
        followers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowersData(userName: userName, page: page)
    }
}
