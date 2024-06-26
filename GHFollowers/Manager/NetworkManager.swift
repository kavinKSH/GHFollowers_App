//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Kavin on 26/03/24.
//

import UIKit

struct NetworkManager {
    
    static let shared   = NetworkManager()
    let cache           = NSCache<NSString, UIImage>()
    let decoder         = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getFollowersList(endpoints: Endpoints?) async throws ->[Followers] {
        guard let url =  endpoints?.url else {
            throw GFError.invalidUserName
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        do {
            return try decoder.decode([Followers].self, from: data)
        }catch {
            throw GFError.invalidData
        }
    }
    
    func getUsers(endpoints: Endpoints) async throws -> Users {
        guard let url = endpoints.url else {
            throw GFError.invalidUserName
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        do {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Users.self, from: data)
        }catch {
            throw GFError.invalidData
        }
    }
    
    func downloadingImages(imageURL: String) async -> UIImage? {
        let cacheKey = NSString(string: imageURL)
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        guard let url = URL(string: imageURL) else {return nil}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        }catch {
            return nil
        }
    }
}

//    func downLoadImages(url: String, completed: @escaping (UIImage?)->Void) {
//        let cacheKey = NSString(string: url)
//        if let image = cache.object(forKey: cacheKey) {
//            completed(image)
//        }
//        guard let url = URL(string: url) else {
//            completed(nil)
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let _ = error {
//                return
//            }
//            guard let response = response as? HTTPURLResponse,
//                  response.statusCode == 200,
//                  let data = data,
//                  let image = UIImage(data: data)
//            else {
//                completed(nil)
//                return
//            }
//            completed(image)
//            cache.setObject(image, forKey: cacheKey)
//        }
//        task.resume()
//    }

//    func getFollowersList(userName: String, page: Int, completion: @escaping (Result<[Followers], GFError>)->Void) {
//        let endpoints = baseURL + "/users/\(userName)/followers?per_page=100&page=\(page)"
//
//        guard let url = URL(string: endpoints) else {
//            completion(.failure(.invalidUserName))
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if error != nil {
//                completion(.failure(.unableToComplete))
//            }
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let followers = try decoder.decode([Followers].self, from: data)
//                completion(.success(followers))
//            }catch {
//                completion(.failure(.invalidData))
//            }
//        }
//        task.resume()
//    }
//


