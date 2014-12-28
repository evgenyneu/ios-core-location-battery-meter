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

  private var notificationCountdown = 0

  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager.delegate = self
    restartUpdatingLocation()
    Notification.registerNotifications()
  }

  @IBAction func onStartTapped(sender: AnyObject) {
    LogViewController.clear()
    restartUpdatingLocation()
  }

  private func restartUpdatingLocation() {
    startTimeLabel.text = ""
    locationUpdateLabel.text = ""
    accuracyLabel.text = ""

    locationManager.stopUpdatingLocation()

    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    accuracyLabel.text = "desiredAccuracy: \(Int(locationManager.desiredAccuracy))m"

    startTimeLabel.text = "Started \(currentDateAndTime)"

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

  private var currentDateAndTime: String {
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.timeStyle = .ShortStyle
    formatter.dateStyle = .ShortStyle
    return formatter.stringFromDate(date)
  }

  class var currentTime: String {
    let date = NSDate()
    let formatter = NSDateFormatter()
    formatter.timeStyle = .MediumStyle
    return formatter.stringFromDate(date)
  }

  private func notify(text: String) {
    if notificationCountdown == 0 {
      notificationCountdown = 10
    }

    notificationCountdown--

    if notificationCountdown == 1 {
      Notification.send(text)
    }
  }
}

// CLLocationManager Delegate
// ------------------------------

typealias ExtCLLocationManagerDelegate = ViewController

extension ExtCLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    if let currentLocation = locations.last as? CLLocation {
      let text = "[\(ViewController.currentTime)] \(currentLocation.horizontalAccuracy)"
      locationUpdateLabel.text = text

      LogViewController.add(text)

      // Uncomment to see that updates are coming when app is in background
//      notify(locationUpdateLabel.text!)
    }
  }
}
