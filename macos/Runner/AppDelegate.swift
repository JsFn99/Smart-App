import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  GMSServices.provideAPIKey("AIzaSyC-LS1R0Tz8QMXwFiIWR5F8A54qVfhDDc4")
}
