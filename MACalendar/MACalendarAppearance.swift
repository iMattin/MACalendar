//
//  MACalendarAppearance.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/19/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import UIKit


public struct MACalendarAppearance {
    static let `default` = MACalendarAppearance()

    
    public var toolBarBGColor: UIColor? = #colorLiteral(red: 1, green: 0, blue: 0.2879999876, alpha: 1)
    public var yearFGColor: UIColor? = .white
    public var monthFGColor: UIColor? = .white
    public var weekdayFGColor: UIColor? = .black
    public var weekdayBGColor: UIColor? = .clear


    public var calendarBGColor: UIColor? = .white

    public var buttonFGColor: UIColor? = .white
    public var buttonBGColor: UIColor? = .clear

    public var selectedDayBGColor: UIColor? = #colorLiteral(red: 0.03398141662, green: 0.5353088579, blue: 0.7464761078, alpha: 1)
    public var hilightedDayBGColor: UIColor? = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.5)
    public var normalDayBGColor: UIColor? = .clear
    public var selectedDayFGColor: UIColor? = .white
    public var hilightedDayFGColor: UIColor? = .black
    public var normalDayFGColor: UIColor? = .black
    public var holidayFGColor: UIColor? = .red
    public var todayBGColor: UIColor? = .blue
    public var todayFGColor: UIColor? = .white
    public var hintFGColor: UIColor? = .white


    public var toolBarFont: UIFont? = UIFont.systemFont(ofSize: 15)
    public var weekdayFont: UIFont? = UIFont.systemFont(ofSize: 15)
    public var calendarFont: UIFont? = UIFont.systemFont(ofSize: 12)
    public var hintFont: UIFont? = UIFont.systemFont(ofSize: 12)


    public init() {}
}
