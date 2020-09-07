//
//  CalendarView.swift
//  fujiko
//
//  Created by Charlie Cai on 12/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import Foundation
import JTAppleCalendar
import RxSwift
import RxCocoa

@IBDesignable
class CalendarView: JTACMonthView {
    
    let dateRelay = BehaviorRelay(value: Date())
    
    override init() {
        super.init()
    
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
    }
    
    private func makeUI() {
        
        register(CalendarDateCell.self, forCellWithReuseIdentifier: CalendarDateCell.identifier)
        
        // 元素间距 行间距 全部为0 滚动方向水平
        scrollDirection = .horizontal
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        
        // 分页
        isPagingEnabled = true
        // 隐藏水平滚动条
        showsHorizontalScrollIndicator = false
        calendarDataSource = self
        calendarDelegate = self
        backgroundColor = UIColor(Theme.Color.background_light)
        
    }
    
    // All Cell UI Logic Goes Here
    private func configureCell(cell: JTACDayCell?, cellState: CellState) {
        guard let calendarDateCell = cell as? CalendarDateCell else {
            return
        }
        
        // Set Text
        calendarDateCell.dayLabel.text = cellState.text
        
        // Set Text Color
        if cellState.dateBelongsTo == .thisMonth {
            let textColor = cellState.isSelected ? UIColor.white : UIColor.black
            calendarDateCell.dayLabel.textColor = textColor
        } else {
            calendarDateCell.dayLabel.textColor = UIColor.lightGray
        }
        
        // Set selection/deselection status
        calendarDateCell.setSelection(cellState.isSelected)
    }
    
}

extension CalendarView: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2000 01 01")!
        let endDate = formatter.date(from: "2090 01 01")!
        let calendarRows = 5
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       numberOfRows: calendarRows,
                                       generateInDates: .forAllMonths ,
                                       generateOutDates: .tillEndOfRow)
    }
    
}

extension CalendarView: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView,
                  willDisplay cell: JTACDayCell,
                  forItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) {
        
        configureCell(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTACMonthView,
                  cellForItemAt date: Date,
                  cellState: CellState,
                  indexPath: IndexPath) -> JTACDayCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(
        withReuseIdentifier: CalendarDateCell.identifier, for: indexPath)
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
        
    }
    
    func calendar(_ calendar: JTACMonthView,
                  didSelectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) {
        Logger.log("Calendar Selected", .verbose)
        
        if let cell = cell {
            self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        }

    }
    
    func calendar(_ calendar: JTACMonthView,
                  didDeselectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) {
        Logger.log("Calendar Deselected", .verbose)
        
        if let cell = cell {
            self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        }
    }
    
    func calendar(_ calendar: JTACMonthView,
                  shouldSelectDate date: Date,
                  cell: JTACDayCell?,
                  cellState: CellState,
                  indexPath: IndexPath) -> Bool {
        
        // Only Current Month Cell Selectable
        return cellState.dateBelongsTo == .thisMonth
    }
    
    func calendar(_ calendar: JTACMonthView, willScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        
        if let date = visibleDates.monthDates.first?.date {
            dateRelay.accept(date)
        }
        
    }
    
}

extension Reactive where Base: CalendarView {
    
    internal var pageTranslation: Binder<SegmentDestination> {
        return Binder(self.base) { view, translation in
            view.scrollToSegment(translation,
                                 triggerScrollToDateDelegate: true,
                                 animateScroll: true,
                                 extraAddedOffset: 0,
                                 completionHandler: nil)
        }
    }
    
    internal var date: BehaviorRelay<Date> {
        return self.base.dateRelay
    }
    
}
