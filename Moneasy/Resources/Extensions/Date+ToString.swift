//
//  Date+ToString.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import Foundation

extension Date {

    func toString(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
}
