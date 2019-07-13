//
//  CalendarView.swift
//  VIP
//
//  Created by Mattin Abdollahi on 4/18/1398 AP.
//  Copyright © 1398 Mattin Abdollahi. All rights reserved.
//

import UIKit



public class MACalendarView: UIView {

    private let NIB_NAME = "MACalendarView"
    private let BUNDLE = Bundle(identifier: "com.matin.MACalendar.MACalendar")!

    private var calendar: Calendar!


    public weak var singleDelegate: MASingleCalendarDelegate?
    public weak var rangeDelegate: MARangeCalendarDelegate?




    private var days: [MADay?] = [] {
        didSet { self.collectionView.reloadData()
        }
    }



    private var year: String? {
        didSet {
            self.yearLabel.text = year
        }
    }


    private var month: String? {
        didSet {
            self.monthLabel.text = month
        }
    }



    public var appearance: MACalendarAppearance = MACalendarAppearance.default {
        didSet {
            self.updateUI()
        }
    }


    public var config: MACalendarConfig = MACalendarConfig.default {
        didSet {
            self.configure()
        }
    }



    public var hint: String? = nil {
        didSet {
            self.hintLabel.text = hint
        }
    }

    private var leftArrowImage: UIImage? {
        let image = UIImage(named: "ic_left_arrow" , in: BUNDLE, compatibleWith: nil)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        return tintedImage
    }

    private var rightArrowImage: UIImage? {
        let image = UIImage(named: "ic_right_arrow" , in: BUNDLE, compatibleWith: nil)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        return tintedImage
    }

    private var monthSymbols: [String]!
    private var weekdaySymbols: [String]!
    private var shortWeekdaySymbols: [String]!


    // MACalendarType = .multiple
    private var startDate: Date?
    private var endDate: Date?

    // MACalendarType = .single
    private var selectedDate: Date?

    // visible year & month on calendar - First day of solar month (yyyy/MM/01)
    private var currentMonthDate: Date!


    @IBOutlet var shortWeekdayLabels: [UILabel]!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var toolBarView: UIView!
    @IBOutlet weak var weekdayView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! { didSet { self.configCollectionView() } }
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!



    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }



    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }





    private func commonInit() {
        BUNDLE.loadNibNamed(NIB_NAME, owner: self, options: nil)
        self.contentView.fixInView(self)
        self.configure()
    }



    private func configure() {
        switch self.config.mode {
        case .solar:
            self.calendar = Calendar(identifier: .persian)
            calendar.locale = Locale(identifier: "fa_IR")
            collectionView.semanticContentAttribute = .forceRightToLeft
        case .gregorian:
            self.calendar = Calendar(identifier: .gregorian)
            calendar.locale = Locale(identifier: "en_US")
            collectionView.semanticContentAttribute = .forceLeftToRight
        }
        calendar.timeZone = TimeZone(identifier: "GMT")!
        self.monthSymbols = calendar._monthSymbols
        self.weekdaySymbols = calendar._weekdaySymbols
        self.shortWeekdaySymbols = calendar._veryShortWeekdaySymbols
        _ = self.shortWeekdaySymbols.enumerated().map { self.shortWeekdayLabels[$0].text = $1 }
        self.currentMonthDate = calendar.date(from:  calendar.dateComponents([.year , .month], from: config.defaultDate))!
        self.reloadCalendar()
    }



    public override func layoutSubviews() {
        self.layoutCollectionView()
        self.updateUI()
    }



    private func layoutCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        let width = (collectionView.frame.width - 8)  / 7
        let height = (collectionView.frame.height) / 6
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        collectionView.collectionViewLayout = flowLayout
    }



    private func configCollectionView() {
        let cellNib = UINib(nibName: "DayCollectionViewCell", bundle: Bundle(identifier: "com.matin.MACalendar.MACalendar"))
        collectionView.register(cellNib, forCellWithReuseIdentifier: "dayCell")
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.dataSource = self
        collectionView.delegate = self
    }



    public func updateUI() {
        self.collectionView.backgroundColor = self.appearance.calendarBGColor
        self.toolBarView.backgroundColor = self.appearance.toolBarBGColor
        self.yearLabel.textColor = self.appearance.yearFGColor
        self.monthLabel.textColor = self.appearance.monthFGColor
        self.yearLabel.font = self.appearance.toolBarFont
        self.monthLabel.font = self.appearance.toolBarFont
        self.shortWeekdayLabels.forEach { $0.textColor = appearance.weekdayFGColor; $0.font = appearance.weekdayFont  }
        self.weekdayView.backgroundColor = appearance.weekdayBGColor
        self.rightButton.backgroundColor = self.appearance.buttonBGColor
        self.leftButton.backgroundColor = self.appearance.buttonBGColor
        self.rightButton.setImage(self.rightArrowImage, for: .normal)
        self.leftButton.setImage(self.leftArrowImage, for: .normal)
        self.hintLabel.font = self.appearance.hintFont
        self.hintLabel.textColor = self.appearance.hintFGColor
        self.collectionView.reloadData()
    }



    private func reloadCalendar() {
        let firstWeekdayInMonth = calendar.weekday(calendar.component(.weekday, from: currentMonthDate))
        let daysInMonth = calendar.range(of: .day, in: .month, for: currentMonthDate)!.count
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = calendar.locale
        var days: [MADay?] = Array<MADay?>.init(repeating: nil, count: 42)
        for (index , i) in (firstWeekdayInMonth..<(daysInMonth + firstWeekdayInMonth)).enumerated() {
            let date = calendar.date(byAdding: .day, value: index, to: self.currentMonthDate)!
            let isToday = (self.config.showToday && calendar.isDate(date, inSameDayAs: Date()))
            let monthday = numberFormatter.string(from: NSNumber(value: index + 1))
            let day = MADay(date: date, monthday: monthday, state: state(for: date), isEnabled: self.enable(date: date), isToday: isToday ,occasion: nil)
            days[i] = day
        }
        self.days = days
        self.year = numberFormatter.string(from: NSNumber(value: self.calendar.component(.year, from: self.currentMonthDate)))
        self.month = self.monthSymbols[self.calendar.component(.month, from: self.currentMonthDate) - 1]
    }



    private func nextMonth() {
        self.currentMonthDate = calendar.date(byAdding: .month, value: 1, to: self.currentMonthDate)!
        self.reloadCalendar()
    }



    private func prevMonth() {
        self.currentMonthDate = calendar.date(byAdding: .month, value: -1, to: self.currentMonthDate)!
        self.reloadCalendar()
    }



    private func selectStartDate(_ date: Date) {
        guard self.rangeDelegate?.calendarView(self, canSelectStartDate: MADate.createFrom(date: date, format: config.format)) ?? true else { return }
        self.startDate = date
        self.rangeDelegate?.calendarView(self, didSelectStartDate: MADate.createFrom(date: date, format: config.format))

    }



    private func selectEndDate(_ date: Date) {
        guard self.rangeDelegate?.calendarView(self, canSelectEndDate: MADate.createFrom(date: date, format: config.format)) ?? true else { return }
        self.endDate = date
        self.rangeDelegate?.calendarView(self, didSelectEndDate: MADate.createFrom(date: date, format: config.format))
        self.rangeDelegate?.calendarView(self, didSelectDates: self.calendar.dates(from: self.startDate!, to: self.endDate!).map { MADate.createFrom(date: $0 , format: config.format) })
    }



    private func rangeSelect(day: MADay) {
        if self.startDate == nil {
            self.selectStartDate(day.date)
        }else if self.endDate == nil {
            if day.date >= self.startDate! {
                self.selectEndDate(day.date)
            }else {
                self.selectStartDate( day.date)
            }
        }else {
            self.selectStartDate(day.date)
            self.endDate = nil
        }
    }



    private func singleSelect(day: MADay) {
        guard self.singleDelegate?.calendarView(self, canSelectDate: MADate.createFrom(date: day.date, format: config.format)) ?? true else { return }
        self.selectedDate = day.date
        self.singleDelegate?.calendarView(self, didSelectDate: MADate.createFrom(date: day.date, format: config.format))
    }



    @IBAction private func leftButtonTapped(_ sender: UIButton) {
        self.config.mode == .solar ? self.nextMonth() : self.prevMonth()
    }



    @IBAction private func rightButtonTapped(_ sender: UIButton) {
        self.config.mode == .solar ? self.prevMonth() : self.nextMonth()
    }

}






extension MACalendarView: UICollectionViewDelegate , UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.days.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! DayCollectionViewCell
        cell.configure(day: self.days[indexPath.row] , appearance: appearance)
        return cell
    }


    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = self.days[indexPath.row]!
        guard day.isEnabled else { return }
        switch self.config.selectionType {
        case .range:
            self.rangeSelect(day: day)
        case .single:
            self.singleSelect(day: day)
        }
        self.reloadCalendar()
    }

}





extension MACalendarView {

    private func enable(date: Date) -> Bool {
        if let minDate = self.config.minimumDate {
            guard date >= calendar.date(from: calendar.dateComponents([.year , .month , .day], from: minDate))! else { return false }
        }
        if let maxDate = self.config.maximumDate {
            guard date <= calendar.date(from: calendar.dateComponents([.year , .month , .day], from: maxDate))! else { return false }
        }
        return true
    }


    private func hilight(date: Date) -> Bool {
        guard self.config.selectionType == .range, let sDate = startDate , let eDate = endDate else { return false }
        return (sDate < date) && (eDate > date)
    }


    private func select(date: Date) -> Bool {
        switch self.config.selectionType {
        case .single:
            return self.selectedDate == date
        case .range:
            return (self.startDate == date || self.endDate == date)
        }
    }


    private func holiday(date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        return self.config.mode == .solar ? weekday % 6 == 0 : weekday % 7 == 0
    }


    private func state(for date: Date) -> MADayState {
        if select(date: date) { return .select }
        if hilight(date: date) { return .hilight }
        if holiday(date: date) { return .holiday(occasion: nil) }
        return .normal
    }

}




extension UIView {
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }

    class func instanceFromNib(nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: Bundle(identifier: "com.matin.MACalendar.MACalendar")).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}


