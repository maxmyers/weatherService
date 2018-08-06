//
//  SplitViewController.swift
//  WeatherService
//
//  Created by david Myers on 8/5/18.
//  Copyright © 2018 Max Myers. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController,UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
