//
//  BarChartsVC0.swift
//  ChartSamplesSwift
//
//  Created by Santhosh K on 17/04/24.
//

import UIKit

class BarChartsVC0: UIViewController {

    @IBOutlet weak var barChartVW: UIView!
    
    
    
    let xlabels = ["One", "Two", "Three", "Four", "Five"]
    let xValues = [15.0, 20.0, 23.0, 15.0, 10.0]
    let yValues = [30.0, 30.0, 30.0, 30.0, 30.0]
    var colors = [UIColor.systemRed, UIColor.systemYellow, UIColor.systemBlue]
    
    
    var barChartView = myBarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBarChartView(xlabels, xValues: xValues, yValues: yValues, barColors: colors)

    }
    
    
    func addBarChartView(_ xLabels:[String], xValues:[Double], yValues:[Double], barColors:[UIColor]) {
        DispatchQueue.main.async {
            self.barChartView.frame =  CGRect(x: self.barChartVW.bounds.origin.x, y: self.barChartVW.bounds.origin.y, width: self.barChartVW.bounds.width, height: self.barChartVW.bounds.height)
            self.barChartVW.addSubview(self.barChartView)
            self.barChartView.barChartSetup(xLabels, xValues: xValues, yValues: yValues, barColors: barColors)
        }
    }
    
    func removeSubviews() {
        DispatchQueue.main.async {
            self.barChartView.removeFromSuperview()
        }
    }

}
