//
//  BarChartsVC1.swift
//  ChartSamplesSwift



import UIKit
import DGCharts

class BarChartsVC1: UIViewController, ChartViewDelegate {
    
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var indexV = Int()
    
    let players = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
    let goals:[Double] = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
    var colors = [UIColor.orange, UIColor.yellow, UIColor.blue]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "one way"
        
        self.barchartSetup()
        
        barChartView.delegate = self
        barChartView.legend.enabled = false
    }

}

extension BarChartsVC1 {
    
    func barchartSetup() {
        
        self.barChartView.setBarChartData(xValues: players, yValues: goals, colors: colors, label: "Bar chart")
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.spaceMin = 10
        
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.rightAxis.drawLabelsEnabled = false
        
        // Hide bottom axis line
                barChartView.xAxis.drawAxisLineEnabled = false
        
        // Disable user interaction with the chart
               barChartView.isUserInteractionEnabled = false
        
        
        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        barChartView.xAxis.labelCount = 3
        
        // Show dataset label ("Units Sold")
         barChartView.legend.enabled = false
        
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        
        print(chartView)
        print(entry)
        print(highlight)
//            let marker: BalloonMarker = BalloonMarker(color: Colors._9e9e9e.color,
//                                                      font: UIFont.systemFont(ofSize: 10),
//                                                      textColor: .white,
//                                                      insets: UIEdgeInsets(top: 5.0, left: 5.0, bottom: 7.0, right: 5.0))
//            marker.isPercent = self.isPercent
//            marker.minimumSize = CGSizeMake(50, 35)
//            chartView.marker = marker
//
//            self.myBarChart.centerViewToAnimated(xValue: entry.x,
//                                                 yValue: entry.y,
//                                                 axis: self.myBarChart.data![highlight.dataSetIndex].axisDependency,
//                                                                 duration: 0.7)
        }
    
    
}


extension BarChartView {
///reference - notes
    ///reference//https://github.com/ChartsOrg/Charts/issues/1340
    ///
    ///For Corner radius -
    ///
    ///BarChartRenderer ->   drawDataSet(context: CGContext, dataSet: BarChartDataSetProtocol, index: Int)
    /////context.fill(barRect) replace with
    ////*
    ///let bezierPath = UIBezierPath(roundedRect: barRect, cornerRadius: 5)
    /// context.addPath(bezierPath.cgPath)
    /// context.drawPath(using: .fill)
    ///*/
    ///
    ///
    ///
    ///
    ///
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
    
    func setBarChartData(xValues: [String], yValues: [Double], colors:[UIColor],label: String) {
        
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let mx = (yValues.max() ?? 0) + 20
        
        for i in 0..<yValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: mx)
            dataEntries1.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: label)
        
        chartDataSet.colors = colors
//        chartDataSet.barShadowColor = .systemGray5
        chartDataSet.drawValuesEnabled = false
        
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1)
        chartDataSet1.colors = [.lightGray]
        chartDataSet1.drawValuesEnabled = false
        
        
        
        //let chartData = BarChartData(dataSet: chartDataSet)
        let chartData = BarChartData(dataSets: [chartDataSet1, chartDataSet])
                
                
        let chartFormatter = BarChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        self.xAxis.setLabelCount(xValues.count, force: false)
        self.data = chartData
    }
}


