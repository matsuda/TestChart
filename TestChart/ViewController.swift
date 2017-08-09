//
//  ViewController.swift
//  TestChart
//
//  Created by matsuda on 2017/08/09.
//
//

import UIKit

final class ViewController: UIViewController {

    lazy var dispatch_once: Void = {
        self.performSegue(withIdentifier: "ShowChart", sender: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = dispatch_once
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
