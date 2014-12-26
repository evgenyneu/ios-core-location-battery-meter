# iOS location updates battery usage meter

This is a demo iOS app that can help to measure power consumption of core location updates in different modes.

Here is how I use it:

* First, set desired `locationManager.desiredAccuracy` or other settings.

* Start the app and make it run for several hours. The app is configured to receive location updates in the background.

* Finally, check the start and end battery level.

Important thing to remember is to stop all other apps that use location services, so the app runs in isolation.

