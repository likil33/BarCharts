//
//  BarCharts3.swift
//  ChartSamplesSwift
//
//  Created by Santhosh K on 16/04/24.
//

import UIKit

class BarCharts3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedBarChartView = RoundedBarChartView(frame: CGRect(x: 50, y: 50, width: 300, height: 300))
        roundedBarChartView.values = [0.2, 0.5, 0.7] // Example data
        roundedBarChartView.labels = ["Medium", "Low", "High",] // Example labels
        //roundedBarChartView.barShadowColor = .gray // Set the shadow color
        roundedBarChartView.colors = [.red, .green, .blue] // Example custom colors
        view.addSubview(roundedBarChartView)
    }
    

}






import UIKit

class RoundedBarChartView: UIView {

    var values: [CGFloat] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var labels: [String] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    
    var barSpacing: CGFloat = 10 // Adjust the spacing between bars here
    var colors: [UIColor] = [] // Array to hold custom colors for bars
    var barMaxHeight: CGFloat = 150 // Maximum height for the bars
//    var barmax = values.max
    var selectedBarIndex: Int? // Index of the currently selected bar
    var valueLabels: [UILabel] = [] // Array to hold value labels
    
    var backgroundBarColor: UIColor = UIColor.lightGray.withAlphaComponent(0.5) // Background bar color
    var backgroundBarCornerRadius: CGFloat = 10 // Corner radius for background bar

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let heigh = (rect.height  * CGFloat(values.max() ?? 0))
        barMaxHeight = heigh
        
        // Fill the background with white color
        UIColor.white.setFill()
        UIRectFill(rect)
        
        guard !values.isEmpty && labels.count == values.count else {
            return
        }
        
        let totalSpacing = CGFloat(values.count - 1) * barSpacing
//        let barWidth = (rect.width - CGFloat(values.count - 1) * barSpacing) / CGFloat(values.count)
        let barWidth1 = (rect.width - totalSpacing) / CGFloat(values.count) // Adjust the width here
        
        let barWidth = barWidth1 - 15
        let context = UIGraphicsGetCurrentContext()
        
        
        for (index, value) in values.enumerated() {
            let barHeight = min(barMaxHeight, rect.height * value)
            let barRect = CGRect(x: CGFloat(index) * (barWidth + barSpacing),
                                 y: rect.height - barHeight,
                                 width: barWidth,
                                 height: barHeight)
            
            
            // Draw background bar
            let backgroundBarHeight = barMaxHeight + 50
            let backgroundBarRect = CGRect(x: barRect.origin.x,
                                           y: rect.height - backgroundBarHeight,
                                           width: barWidth,
                                           height: backgroundBarHeight)
            let backgroundBarPath = UIBezierPath(roundedRect: backgroundBarRect, cornerRadius: backgroundBarCornerRadius)
            context?.setFillColor(backgroundBarColor.cgColor)
            context?.addPath(backgroundBarPath.cgPath)
            context?.fillPath()
            
            
            
            // Draw value bar
            let radius = min(barRect.width, barRect.height) * 0.1 // Adjust the radius here
            let path = UIBezierPath(roundedRect: barRect, cornerRadius: radius)
            
            // Set bar color
            let barColor = colors.indices.contains(index) ? colors[index] : UIColor.blue
            context?.setFillColor(barColor.cgColor)
            
            context?.addPath(path.cgPath)
            context?.fillPath()
            
            // Draw X-axis labels
            let label = UILabel(frame: CGRect(x: barRect.origin.x, y: rect.height + 5, width: barWidth, height: 20))
            label.text = labels[index]
            label.font = UIFont.systemFont(ofSize: 11)
            label.textAlignment = .center
            addSubview(label)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)

        for (index, value) in values.enumerated() {
            let barWidth1 = (bounds.width - CGFloat(values.count - 1) * barSpacing) / CGFloat(values.count)
            let barWidth = barWidth1 - 15
            let barHeight = min(barMaxHeight, bounds.height * value)
            let barRect = CGRect(x: CGFloat(index) * (barWidth + barSpacing),
                                 y: bounds.height - barHeight,
                                 width: barWidth,
                                 height: barHeight)

            if barRect.contains(point) {
                if selectedBarIndex != nil {
                    hideValueLabel()
                }
                showValueLabel(at: barRect, value: value)
                selectedBarIndex = index
                return
            }
        }
        hideValueLabel()
        selectedBarIndex = nil
    }

    private func showValueLabel(at rect: CGRect, value: CGFloat) {
        let label = UILabel(frame: CGRect(x: rect.midX - 25, y: rect.origin.y - 25, width: 50, height: 20))
        label.textAlignment = .center
        label.text = "\(value)"
        addSubview(label)
        valueLabels.append(label)
    }

    private func hideValueLabel() {
        for label in valueLabels {
            label.removeFromSuperview()
        }
        valueLabels.removeAll()
    }
}
