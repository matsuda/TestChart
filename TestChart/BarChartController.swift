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

    struct PlotData {
        let date: TimeInterval
        let value: Double
    }
    var plots: [PlotData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preparePlotData()
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
    func preparePlotData() {
        plots = [
            PlotData(date: Date(timeIntervalSinceNow: -60*60*24*4).timeIntervalSince1970, value: 100),
            PlotData(date: Date(timeIntervalSinceNow: -60*60*24*3).timeIntervalSince1970, value: 50),
            PlotData(date: Date(timeIntervalSinceNow: -60*60*24*2).timeIntervalSince1970, value: 20),
            PlotData(date: Date(timeIntervalSinceNow: -60*60*24*1).timeIntervalSince1970, value: 80),
        ]
    }

    func prepareChart() {
        chartView.extraTopOffset = 30
        chartView.chartDescription?.enabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.pinchZoomEnabled = false

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.labelCount = 4
        xAxis.valueFormatter = DateAxisValueFormatter(chart: chartView, dates: plots.map { $0.date })

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
        let entries: [BarChartDataEntry] = plots.enumerated().map { (i, data) -> BarChartDataEntry in
            BarChartDataEntry(x: Double(i), y: data.value)
        }
        let dataSet = BarChartDataSet(values: entries, label: "test")
        let data = BarChartData(dataSet: dataSet)
        data.setValueFont(UIFont.systemFont(ofSize: 12))
        chartView.data = data
    }
}

//extension BarChartController: IAxisValueFormatter {
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return "x = \(value)"
//    }
//}

final class DateAxisValueFormatter: NSObject, IAxisValueFormatter {
    private weak var _chart: BarLineChartViewBase!
    private let dates: [TimeInterval]
    private let formatter: DateFormatter

    init(chart: BarLineChartViewBase, dates: [TimeInterval]) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "MM/dd\nyyyy\n23\u{2103}"
        self.formatter = formatter
        self.dates = dates
        _chart = chart
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let idx = Int(value)
        let date = Date(timeIntervalSince1970: dates[idx])
        return formatter.string(from: date)
    }
}
