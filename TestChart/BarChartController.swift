//
//  BarChartController.swift
//  TestChart
//
//  Created by matsuda on 2017/08/09.
//
//

import UIKit
import Charts

final class BarChartController: UIViewController {

    @IBOutlet weak var chartView: BarChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareChart()
        setChartData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension BarChartController {
    func prepareChart() {
        chartView.extraTopOffset = 30
        chartView.chartDescription?.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.labelCount = 4

        let leftAxis = chartView.leftAxis
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 100
        leftAxis.drawZeroLineEnabled = true
        leftAxis.labelCount = 2

        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false

        let legend = chartView.legend
        legend.enabled = false
    }

    func setChartData() {
        let entries: [BarChartDataEntry] = [
            BarChartDataEntry(x: 1, y: 100),
            BarChartDataEntry(x: 2, y: 50),
            BarChartDataEntry(x: 3, y: 20),
            BarChartDataEntry(x: 4, y: 80),
        ]
        let dataSet = BarChartDataSet(values: entries, label: "test")
        let data = BarChartData(dataSet: dataSet)
        data.setValueFont(UIFont.systemFont(ofSize: 12))
        chartView.data = data
    }
}
