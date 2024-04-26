//
//  CustomError.swift
//  GHFollowers
//
//  Created by Kavin on 27/03/24.
//

import Foundation

enum GFError :String, Error {
    case invalidUserName = "This username creater an Invalid request, Please try again!"
    case  unableToComplete = "Unable to complete your requests, Please check your Internet connection"
    case invalidData = "The Invalid data retrived from the server, Please try again!"
    case invalidResponse = "Invalid response from the server, Please try again later!"
    case unableToFavorites = "you dont add a any favorites people, Please add favorites "
    case alreadyInFavorites = "Already This user are favorited persons, You must really like them"
}
