//
//  BarChartsVC2.swift
//  ChartSamplesSwift
//
//  Created by Santhosh K on 07/04/24.
//

import UIKit
import DGCharts

class BarChartsVC2: UIViewController {

    
    @IBOutlet weak var barChartView: BarChartView!
    
    
    @IBOutlet weak var barChartView1: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.practice()
        self.practice1()
    }
    


}

extension BarChartsVC2 {
    func practice() {
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
               let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        let unitsSold1 = [30.0, 30.0, 30.0, 30.0, 30.0, 30.0]

               // Create entries for the bar chart
               let entries = unitsSold.enumerated().map { (index, value) in
                   BarChartDataEntry(x: Double(index), y: value)
               }
        
        let entries1 = unitsSold1.enumerated().map { (index, value) in
            BarChartDataEntry(x: Double(index), y: value)
        }

               // Set custom X-axis labels (months)
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        barChartView.xAxis.granularity = 1 // Show all labels

        
        // Create a dataset
        let dataSet1 = BarChartDataSet(entries: entries1, label: "Units Sold")
        dataSet1.colors = [NSUIColor.lightGray]
        
               // Create a dataset
               let dataSet = BarChartDataSet(entries: entries, label: "Units Sold")
               dataSet.colors = [NSUIColor.blue]
        
        

               // Create chart data
               let data = BarChartData(dataSets: [dataSet1,dataSet])
        barChartView.data = data
    }
}



extension BarChartsVC2 {
    func practice1() {
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        let unitsSold1 = [30.0, 30.0, 30.0, 30.0, 30.0, 30.0]
        var colors = [UIColor.orange, UIColor.yellow, UIColor.blue, UIColor.green, UIColor.purple, UIColor.brown]
        
        
        // Create entries for the bar chart
        let entries = unitsSold.enumerated().map { (index, value) in
            BarChartDataEntry(x: Double(index), y: value)
        }
        
        let entries1 = unitsSold1.enumerated().map { (index, value) in
            BarChartDataEntry(x: Double(index), y: value)
        }
        
        // Set custom X-axis labels (months)
        barChartView1.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        barChartView1.xAxis.granularity = 1 // Show all labels
        
        
        // Create a dataset
        let dataSet1 = BarChartDataSet(entries: entries1)
        dataSet1.colors = [NSUIColor.lightGray]
        
        // Create a dataset
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.colors = colors
        
        
//        //xaxis - values display
        let chartFormatter = BarChartFormatter(labels: months)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        barChartView1.xAxis.valueFormatter = xAxis.valueFormatter
        barChartView1.xAxis.setLabelCount(months.count, force: true)
           
        //xaxis - bottom display
        barChartView1.xAxis.labelPosition = .bottom
        
        // xaxis -  Hide bottom axis line
          barChartView.xAxis.drawAxisLineEnabled = false
        
        //xaxis - set values position
        barChartView1.xAxis.labelCount = unitsSold.count
        
        //Grid line hide
        
        barChartView1.xAxis.drawGridLinesEnabled = false
        barChartView1.rightAxis.drawGridLinesEnabled = false
        barChartView1.rightAxis.drawAxisLineEnabled = false
        barChartView1.leftAxis.drawGridLinesEnabled = false
        barChartView1.leftAxis.drawAxisLineEnabled = false
        
        
        //Zoom disable
        barChartView1.pinchZoomEnabled = false
        barChartView1.doubleTapToZoomEnabled = false
        
        
        // Disable user interaction with the chart
               barChartView.isUserInteractionEnabled = false
        
        
        //values display
        barChartView1.drawBarShadowEnabled = false
        barChartView1.drawValueAboveBarEnabled = false
        barChartView1.leftAxis.drawLabelsEnabled = false
        barChartView1.rightAxis.drawLabelsEnabled = false
        
        
        // Create chart data
        let data = BarChartData(dataSets: [dataSet1,dataSet])
        barChartView1.data = data
    }
}






private class BarChartFormatter:IndexAxisValueFormatter {
    
    var labels: [String] = []
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        return labels[Int(value)]
    }
    
    init(labels: [String]) {
        super.init()
        self.labels = labels
    }
}

