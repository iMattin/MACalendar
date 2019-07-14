//
//  MACalendar.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/18/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import UIKit



extension Calendar {

    func dates(from date1: Date , to date2: Date) -> [Date] {
        var dates: [Date] = []
        var date = date1
        repeat {
            dates.append(date)
            date = self.date(byAdding: .day, value: 1, to: date)!
        }while date <= date2
        return dates
    }

    var _monthSymbols: [String] {
        return self.identifier == .persian ? ["فروردین" , "اردیبهشت" , "خرداد" , "تیر" , "مرداد" , "شهرویر" , "مهر" , "آبان" , "آذر" , "دی" , "بهمن" , "اسفند"] : self.monthSymbols
    }

    var _weekdaySymbols: [String] {
        return self.identifier == .persian ? ["شنبه" , "یک شنبه" , "دو شنبه" , "سه شنبه" , "چهار شنبه" , "پنج شنبه" , "جمعه"] : self.weekdaySymbols
    }

    var _veryShortWeekdaySymbols: [String] {
        return self.identifier == .persian ? ["ش" , "ی" , "د" , "س" , "چ" , "پ" , "ج"].reversed() : self.veryShortWeekdaySymbols
    }

    func weekday(_ weekday: Int) -> Int {
        if identifier == .persian {
            return weekday == 7 ? 0 : weekday
        }else {
            return weekday - 1
        }
    }

}
