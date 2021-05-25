import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyC3QZTLUUQAxlik3D9MtzsxaHJG5Y75B8M")//Added this line for google map

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
