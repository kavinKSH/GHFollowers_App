//
//  PresistenceManager.swift
//  GHFollowers
//
//  Created by Kavin on 02/04/24.
//

import Foundation

enum PresistenceType { case add,remove }

enum PresistenceManager {
    
    enum Keys { static let favorites = "favorites" }
    static let defaults = UserDefaults.standard
    
    static func updateFavorite(favorites: Followers, updateType: PresistenceType ,completion: @escaping (GFError?)->Void) {
        
        retriveFavorites { result in
            switch result {
            case .success(var favorite):
                switch updateType {
                case .add:
                    guard !favorite.contains(favorites) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorite.append(favorites)
                case .remove:
                    favorite.removeAll(where: {$0.login == favorites.login})
                }
                completion(save(favorites: favorite))
            case .failure(_):
                completion(.unableToComplete)
            }
        }
    }
    
    static func retriveFavorites(completion: @escaping (Result<[Followers], GFError>)->Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoded = JSONDecoder()
            let favoritesList = try decoded.decode([Followers].self, from: favoritesData)
            completion(.success(favoritesList))
            
        }catch {
            completion(.failure(.unableToFavorites))
        }
    }
    
    static func save(favorites: [Followers]) ->GFError? {
        let encoded = JSONEncoder()
        do {
            let encodedData = try encoded.encode(favorites)
            defaults.setValue(encodedData, forKey: Keys.favorites)
            return nil
        }catch {
            return .unableToFavorites
        }
    }
}










