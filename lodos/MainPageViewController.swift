//
//  MainPageViewController.swift
//  lodos
//
//  Created by Efe Mazlumoğlu on 20.09.2020.
//  Copyright © 2020 Efe Mazlumoğlu. All rights reserved.
//

import Foundation
import UIKit

class MainPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let spinner = SpinnerView.init()
        self.view.addSubview(spinner)
    }
}
