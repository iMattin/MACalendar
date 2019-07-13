//
//  MACalendarDay.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/19/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import Foundation



enum MADayState {
    case normal
    case select
    case hilight
    case holiday(occasion: String?)
}


struct MADay {
    var date: Date!
    var monthday: String!
    var state: MADayState!
    var isEnabled: Bool!
    var isToday: Bool!
    var occasion: String?
}
