//
//  Constant.swift
//  GHFollowers
//
//  Created by Kavin on 04/04/24.
//

import UIKit

enum Images {
    static let ghLogo                   = UIImage(named: "gh-logo-dark")
    static let logoImageView            = UIImage(systemName: "mappin.and.ellipse")
    static let repos                    = UIImage(systemName: "folder")
    static let gists                    = UIImage(systemName: "text.alignleft")
    static let following                = UIImage(systemName: "heart")
    static let followers                = UIImage(systemName: "person.2")
    static let placeholder              = UIImage(named: "avatar-placeholder-dark")
    static let emptyStateLogoImage      = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let maxLength                = max(ScreenSize.width, ScreenSize.height)
    static let minLength                = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    static let isIphoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isIphone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0
    static let isIphone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0
    static let isIphone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isIphone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isIpnoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isIphoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isIpad                   = idiom == .phone && ScreenSize.maxLength == 1024.0
    
    static func isIphoneXAspectRatio()->Bool {
        return isIpnoneX || isIphoneXsMaxAndXr
    }
}
