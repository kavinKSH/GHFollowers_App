//
//  Date + String + Ext.swift
//  GHFollowers
//
//  Created by Kavin on 01/04/24.
//

import Foundation

extension String {
    var convertedString: Date? {
        let dateFormeter = DateFormatter()
        dateFormeter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormeter.locale = Locale(identifier: "en_US_POSIX")
        dateFormeter.timeZone = .current
        return dateFormeter.date(from: self)
//        2021-06-23T15:58:08.489Z
    }
}

extension Date {
    var convertSpecifiedDateFormet: String {
        let dateFormet = DateFormatter()
        dateFormet.dateFormat = "MMM yyyy"
        return dateFormet.string(from: self)
    }
}

extension String {
    func convertedDisplayFormet() -> String {
        guard let date = convertedString else {
            return "N/A"
        }
        return date.convertSpecifiedDateFormet
    }
}
extension Date {
    func convertDateFormet() -> String {
        return formatted(.dateTime.month().year())
    }
}
