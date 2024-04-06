//
//  TodayCard.swift
//  Only77
//
//  Created by yukun xie on 2024/2/15.
//

import Foundation
import SwiftUI


struct TodayCard: Identifiable {
    var id = UUID().uuidString
    var name: String
    var photos: [UIImageColor]
    var title:String
    var title2:String
}


