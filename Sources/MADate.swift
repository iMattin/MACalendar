//
//  MADate.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/20/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import Foundation


public struct MADate: CustomStringConvertible {
    public let date: Date
    public let solarYear: Int
    public let solarMonth: Int
    public let solarDay: Int
    public let solarMonthSymbol: String
    public let solarWeekdaySymbol: String
    public let solarDate: String
    public let gregorianYear: Int
    public let gregorianMonth: Int
    public let gregorianDay: Int
    public let gregorianMonthSymbol: String
    public let gregorianWeekdaySymbol: String
    public let gregorianDate: String


    static func createFrom(date: Date , format: String = "yyyy/MM/dd") -> MADate {

        var sCalendar: Calendar = Calendar(identifier: .persian)
        sCalendar.locale = Locale(identifier: "fa_IR")
        sCalendar.timeZone = TimeZone(identifier: "GMT")!
        let sFormatter = DateFormatter()
        sFormatter.calendar = sCalendar
        sFormatter.dateFormat = format
        sFormatter.locale = sCalendar.locale

        var gCalendar: Calendar = Calendar(identifier: .gregorian)
        gCalendar.locale = Locale(identifier: "en_US")
        gCalendar.timeZone = TimeZone(identifier: "GMT")!
        let gFormatter = DateFormatter()
        gFormatter.calendar = gCalendar
        gFormatter.dateFormat = format
        gFormatter.locale = gCalendar.locale

        return MADate(date: date,
                      solarYear: sCalendar.component(.year, from: date),
                      solarMonth: sCalendar.component(.month, from: date),
                      solarDay: sCalendar.component(.day, from: date),
                      solarMonthSymbol: sCalendar._monthSymbols[sCalendar.component(.month, from: date) - 1],
                      solarWeekdaySymbol: sCalendar._weekdaySymbols[sCalendar.weekday(sCalendar.component(.weekday, from: date))],
                      solarDate: sFormatter.string(from: date),
                      gregorianYear: gCalendar.component(.year, from: date),
                      gregorianMonth: gCalendar.component(.month, from: date),
                      gregorianDay: gCalendar.component(.day, from: date),
                      gregorianMonthSymbol: gCalendar._monthSymbols[gCalendar.component(.month, from: date) - 1],
                      gregorianWeekdaySymbol: gCalendar._weekdaySymbols[gCalendar.weekday(gCalendar.component(.weekday, from: date))],
                      gregorianDate: gFormatter.string(from: date))
    }
}



public extension MADate {
    var description: String {
        return """
        {MADate Object:
            date: \(date)
            solarYear: \(solarYear)
            solarMonth: \(solarMonth)
            solarDay: \(solarDay)
            solarMonthSymbol: \(solarMonthSymbol)
            solarWeekdaySymbol: \(solarWeekdaySymbol)
            solarDate: \(solarDate)
            gregorianYear: \(gregorianYear)
            gregorianMonth: \(gregorianMonth)
            gregorianDay: \(gregorianDay)
            gregorianMonthSymbol: \(gregorianMonthSymbol)
            gregorianWeekdaySymbol: \(gregorianWeekdaySymbol)
            gregorianDate: \(gregorianDate)
        }
        """
    }
}
