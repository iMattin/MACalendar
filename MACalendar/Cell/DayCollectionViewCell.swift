//
//  DayCollectionViewCell.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/18/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dayLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.dayLabel.layer.cornerRadius = self.dayLabel.frame.width / 2
            self.containerView.layer.cornerRadius = 4
        }
    }


    func configure(day: MADay? , appearance: MACalendarAppearance) {
        guard let unwrappedDay = day else { self.isHidden = true; return }
        self.isHidden = false
        switch unwrappedDay.state! {
        case .normal:
            dayLabel.textColor = appearance.normalDayFGColor
            containerView.backgroundColor = appearance.normalDayBGColor
        case .holiday:
            dayLabel.textColor = appearance.holidayFGColor
            containerView.backgroundColor = appearance.normalDayBGColor
        case .hilight:
            dayLabel.textColor = appearance.hilightedDayFGColor
            containerView.backgroundColor = appearance.hilightedDayBGColor
        case .select:
            dayLabel.textColor = appearance.selectedDayFGColor
            containerView.backgroundColor = appearance.selectedDayBGColor
        }
        containerView.alpha = unwrappedDay.isEnabled ? 1 : 0.5
        self.dayLabel.backgroundColor = unwrappedDay.isToday ? appearance.todayBGColor : UIColor.clear
        self.dayLabel.textColor = unwrappedDay.isToday ? appearance.todayFGColor : self.dayLabel.textColor
        self.dayLabel.font = appearance.calendarFont

        self.dayLabel.text = unwrappedDay.monthday

    }

}
