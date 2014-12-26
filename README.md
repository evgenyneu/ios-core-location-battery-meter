# iOS core locatino power consumption meter

This is a demo iOS app that can help to measure power consumption of core location updates in different modes.

Here is how I use it:

* First, set desired `desiredAccuracy` or other settings of location manager.

* Start the app and make it run for several hours. The app is configured to receive location updates in the background.

* Finally, check the start and end battery level.

Important thing to remember is to stop all other apps that use location services, so the app runs in isolation.

