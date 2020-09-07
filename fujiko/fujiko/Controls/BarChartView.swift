//
//  BarChartView.swift
//  fujiko
//
//  Created by Charlie Cai on 9/3/20.
//  Copyright © 2020 tickboxs. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

@IBDesignable
class BarChartView: View {
    
    private let disposeBag = DisposeBag()
    
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        makeUI()
    }
    
    let statistics = BehaviorRelay<[StatisticsVM]>(value: [])
    
    private func makeUI() {
        
        self.layer.addSublayer(shapeLayer)
        
        layer.shadowColor = UIColor("BCBCBC")?.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        statistics.subscribe(onNext: { [unowned self] _ in
            self.setNeedsDisplay()
        })
        .disposed(by: disposeBag)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let Canvas_Width = rect.size.width
        let Canvas_Height = rect.size.height
        let Y_Axis_Margin: CGFloat = 50.0
        
        // Draw x axis labels
        let weekdays = ["M", "T", "W", "T", "F", "S", "S"]
        let Weekday_Width = (Canvas_Width - Y_Axis_Margin)/(CGFloat)(weekdays.count)
        let Weekday_Height: CGFloat = 40.0
        let X_Offset = 0.5 * Weekday_Width
        
        for (index, weekday) in weekdays.enumerated() {
            
            let rectForWeekday = CGRect(
                x: (CGFloat)(index) * Weekday_Width + X_Offset + Y_Axis_Margin,
                y: Canvas_Height - Weekday_Height,
                width: Weekday_Width,
                height: Weekday_Height)
            
           weekday.draw(in: rectForWeekday)
        }
        
        // Draw y axis labels
        let Y_Offset: CGFloat = 20
        let percentages = ["0%", "25%", "50%", "75%", "100%"]
        let percentages_Width: CGFloat = 50
        let percentages_Height: CGFloat = (Canvas_Height - (Y_Offset * 2 + 5))/(CGFloat)(percentages.count)
        
        for (index, percentage) in percentages.enumerated() {
            
            let rectForPercentage = CGRect(
                x: Y_Offset,
                y: Canvas_Height - ((CGFloat)(index) * percentages_Height) - (Y_Offset * 2 + 5),
                //(Y_Offset * 2 + 5) is number which I tweak for better UI you can change this whenever necessary
                width: percentages_Width,
                height: percentages_Height)
            
           percentage.draw(in: rectForPercentage)
        }
        
        // Draw Bar
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.0
        
        let strokeEndanimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndanimation.duration = 0.5
        strokeEndanimation.fromValue = 0
        strokeEndanimation.toValue = 1
        
        strokeEndanimation.isRemovedOnCompletion = false
        strokeEndanimation.fillMode = .forwards

        strokeEndanimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        shapeLayer.add(strokeEndanimation, forKey: "strokeEndAnimation")
        
        let barPath = UIBezierPath()
        for (index, statisticsVM) in statistics.value.enumerated() {
            
            // Set Stroke Color
            switch  statisticsVM.status {
            case .in_progress:
                shapeLayer.strokeColor = UIColor.blue.cgColor
            case .completed:
                shapeLayer.strokeColor = UIColor.black.cgColor
            case .to_do:
                shapeLayer.strokeColor = UIColor.gray.cgColor
            case .in_review:
                shapeLayer.strokeColor = UIColor.orange.cgColor
            }
                
            let Bar_Width: CGFloat = 10
            let Bar_X_Offset: CGFloat = 5.0
            let Bar_Y_Offset: CGFloat = 5.0
            
            shapeLayer.lineWidth = Bar_Width
            shapeLayer.lineCap = .round
            
            let Factor: CGFloat = CGFloat(statisticsVM.percentage/100.0)
            let Bar_Height = (Canvas_Height - (Y_Offset * 2 + Bar_X_Offset)) * Factor
            
            barPath.move(to: CGPoint(x: (CGFloat)(index) * Weekday_Width + X_Offset + Y_Axis_Margin + Bar_X_Offset,
                                     y: Canvas_Height - Weekday_Height - Bar_Y_Offset))
            barPath.addLine(to: CGPoint(x: (CGFloat)(index) * Weekday_Width + X_Offset + Y_Axis_Margin + Bar_X_Offset,
                                        y: Canvas_Height - Weekday_Height - Bar_Height - Bar_Y_Offset))
        }
        
        shapeLayer.path = barPath.cgPath
    }
}
