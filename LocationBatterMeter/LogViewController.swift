//
//  LogController.swift
//  LocationBatteryUsageMeter
//
//  Created by Evgenii Neumerzhitckii on 28/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

var locationUpdateTimeLog = ""
var lastLogTime = NSDate().dateByAddingTimeInterval(-100)

class LogViewController: UIViewController {
  @IBOutlet weak var logTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()

    logTextView.text = locationUpdateTimeLog
  }

  class func add(text: String) {
    let elapsed = NSDate().timeIntervalSinceDate(lastLogTime)
    if elapsed < 60 { return } // only add to log every minute

    lastLogTime = NSDate()
    locationUpdateTimeLog += text + "\n"
  }
}
