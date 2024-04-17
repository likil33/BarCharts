
import Foundation
import UIKit
import DGCharts





class myBarChartView: BarChartView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    func barChartSetup(_ xLabels:[String], xValues:[Double], yValues:[Double], barColors:[UIColor]) {
        
//        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
//        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
//        let unitsSold1 = [30.0, 30.0, 30.0, 30.0, 30.0, 30.0]
//        var colors = [UIColor.orange, UIColor.yellow, UIColor.blue, UIColor.green, UIColor.purple, UIColor.brown]
        
        let months = xLabels
        let unitsSold = xValues
        let unitsSold1 = yValues
        let colors = barColors
        
        // Create entries for the bar chart
        let entries = unitsSold.enumerated().map { (index, value) in
            BarChartDataEntry(x: Double(index), y: value)
        }
        
        let entries1 = unitsSold1.enumerated().map { (index, value) in
            BarChartDataEntry(x: Double(index), y: value)
        }
        
        // Set custom X-axis labels (months)
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        self.xAxis.granularity = 1 // Show all labels
        
        
        // Create a dataset
        let dataSet1 = BarChartDataSet(entries: entries1)
        dataSet1.colors = [NSUIColor.secondarySystemBackground]
        
        // Create a dataset
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = colors
        
        dataSet.drawValuesEnabled = true
        dataSet1.drawValuesEnabled = true
        
        
        
        //        //xaxis - values display
        let chartFormatter = IndexAxisValueFormatter(values: months)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        self.xAxis.setLabelCount(months.count, force: true)
        
        //xaxis - bottom display
        self.xAxis.labelPosition = .bottom
        
        // xaxis -  Hide bottom axis line
        self.xAxis.drawAxisLineEnabled = false
        
        //xaxis - set values position
        self.xAxis.labelCount = unitsSold.count
        
        //Grid line hide
        
        self.xAxis.drawGridLinesEnabled = false
        self.rightAxis.drawGridLinesEnabled = false
        self.rightAxis.drawAxisLineEnabled = false
        self.leftAxis.drawGridLinesEnabled = false
        self.leftAxis.drawAxisLineEnabled = false
        
        
        //Zoom disable
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        
        
        // Disable user interaction with the chart
        self.isUserInteractionEnabled = false
        
        
        //values display
        self.drawBarShadowEnabled = false
        self.drawValueAboveBarEnabled = false
        self.leftAxis.drawLabelsEnabled = true
        self.rightAxis.drawLabelsEnabled = false
        
        
        self.leftAxis.axisMinimum = 0
        self.leftAxis.axisMaximum = yValues.first ?? 100
        
        // Show dataset label ("Units Sold")
        self.legend.enabled = false
        
        // Create chart data
        let data = BarChartData(dataSets: [dataSet1,dataSet])
        self.data = data
    }
}





//MARK: - NOTES

/*

 //For Corner radius: -
 
 BarChartRenderer -> func  drawDataSet(context: CGContext, dataSet: BarChartDataSetProtocol, index: Int)
    
   context.fill(barRect) replace with
 /*
 let bezierPath = UIBezierPath(roundedRect: barRect, cornerRadius: 5)
  context.addPath(bezierPath.cgPath)
  context.drawPath(using: .fill)
 */
 
 
 */
