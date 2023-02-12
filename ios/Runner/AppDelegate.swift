import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
#if DEBUG
    let providerFactory = AppCheckDebugProviderFactory()
    AppCheck.setAppCheckProviderFactory(providerFactory)
#endif
      
    GeneratedPluginRegistrant.register(with: self)
      
      let controller = window.rootViewController as! FlutterViewController
      
      let flavorChannel = FlutterMethodChannel(
        name: "flavor",
        binaryMessenger: controller.binaryMessenger)
      
      flavorChannel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          let flavor = Bundle.main.infoDictionary?["APP_FLAVOR"]
          result(flavor)
      })
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
