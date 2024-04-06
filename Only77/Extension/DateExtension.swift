//
//  DateExtension.swift
//  Only77
//
//  Created by yukun xie on 2024/3/31.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
