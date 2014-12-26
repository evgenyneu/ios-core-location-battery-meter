//
//  ViewController.swift
//  LocationBatterMeter
//
//  Created by Evgenii Neumerzhitckii on 26/12/2014.
//  Copyright (c) 2014 Evgenii Neumerzhitckii. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

  let locationManager = CLLocationManager()
  @IBOutlet weak var startTimeLabel: UILabel!
  @IBOutlet weak var locationUpdateLabel: UILabel!
  @IBOutlet weak var accuracyLabel: UILabel!
  @IBOutlet weak var batteryLevelLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager.delegate = self
    restartUpdatingLocation()
  }

  @IBAction func onStartTapped(sender: AnyObject) {
    restartUpdatingLocation()
  }

  private func restartUpdatingLocation() {
    startTimeLabel.text = ""
    locationUpdateLabel.text = ""
    accuracyLabel.text = ""

    locationManager.stopUpdatingLocation()

    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    accuracyLabel.text = "Desired accuracy \(locationManager.desiredAccuracy)m"

    startTimeLabel.text = "Started \(currentTime)"

    updateBatteryLevel()

    iiQ.runAfterDelay(1) {
      self.startUpdatingLocation()
    }
  }

  private func updateBatteryLevel() {
    let device = UIDevice.currentDevice()
    device.batteryMonitoringEnabled = true

    batteryLevelLabel.text = "Started with \(Int(device.batteryLevel * 100))% battery"
  }

  private func startUpdatingLocation() {
    if locationManager.respondsToSelector(Selector("requestAlwaysAuthorization")) {
      locationManager.requestAlwaysAuthorization()
    }

    locationManager.startUpdatingLocation()
  }

  private var currentTime: String {
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.timeStyle = .MediumStyle
    formatter.dateStyle = .ShortStyle
    return formatter.stringFromDate(date)
  }
}

// CLLocationManager Delegate
// ------------------------------

typealias ExtCLLocationManagerDelegate = ViewController

extension ExtCLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    if let currentLocation = locations.last as? CLLocation {
      locationUpdateLabel.text =  "[\(currentTime)] accuracy: \(currentLocation.horizontalAccuracy)"
    }
  }
}
