//
//  MACalendarConfig.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/19/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import Foundation

public struct MACalendarConfig {
    static let `default` = MACalendarConfig()

    // set `minimumDate` property to disable all dates which are less than `minimumDate`
    public var minimumDate: Date? = nil

    // set `maximumDate` property to disable all dates which are greater than `maximumDate`
    public var maximumDate: Date? = nil

    // `.single` OR `.multiple`
    public var selectionType: MACalendarSelectionType = .single

    // `defaulDate` will be preview at first time calendar open
    public var defaultDate: Date = Date()

    // hilight date of today
    public var showToday: Bool = true

    public var format: String = "yyyy/MM/dd"

    public var mode: MACalendarMode = .solar

    public var holidays: [MAHoliday] = [MAHoliday(date: "1398/04/19", occasion: "تولد متین")]

    public init() {}
}



