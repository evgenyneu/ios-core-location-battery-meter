# iOS location updates battery usage meter

This is a demo iOS app I am using to measure how much core location updates use the battery.

Here is how I measure the power consumption of using core location modes:

* Set desired `locationManager.desiredAccuracy` in code.

* Start the app and make it run for several hours. The app is configured to receive location updates in the background.

* Finally, check the start and end battery level.

Important thing to remember is to stop all other apps that use location services, so the app runs in isolation.

