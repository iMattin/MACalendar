//
//  MACalendarDelegate.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/21/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import Foundation


public protocol MARangeCalendarDelegate: class {

    func calendarView(_ calendarView: MACalendarView , didSelectDates dates: [MADate])

    func calendarView(_ calendarView: MACalendarView , didSelectStartDate date: MADate)

    func calendarView(_ calendarView: MACalendarView , didSelectEndDate date: MADate)

    func calendarView(_ calendarView: MACalendarView , canSelectStartDate date: MADate) -> Bool

    func calendarView(_ calendarView: MACalendarView , canSelectEndDate date: MADate) -> Bool
}

public extension MARangeCalendarDelegate {
    func calendarView(_ calendarView: MACalendarView , didSelectStartDate date: MADate) { print("Start Date: \(date)") }

    func calendarView(_ calendarView: MACalendarView , didSelectEndDate date: MADate) { print("End Date: \(date)") }

    func calendarView(_ calendarView: MACalendarView , canSelectStartDate date: MADate) -> Bool { return true }

    func calendarView(_ calendarView: MACalendarView , canSelectEndDate date: MADate) -> Bool { return true }
}


public protocol MASingleCalendarDelegate: class {
    func calendarView(_ calendarView: MACalendarView , didSelectDate date: MADate)

    func calendarView(_ calendarView: MACalendarView , canSelectDate date: MADate) -> Bool
}


public extension MASingleCalendarDelegate {
    func calendarView(_ calendarView: MACalendarView , canSelectDate date: MADate) -> Bool { return true }
}
