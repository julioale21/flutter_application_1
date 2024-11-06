import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var securityView: UIView?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Prevenir screenshots
        let field = UITextField()
        field.isSecureTextEntry = true
        self.window?.addSubview(field)
        field.windowLevel = UIWindow.Level.alert + 1
        field.layer.position = CGPoint(x: -1000, y: -1000)
        
        // Observar cuando la app entra en background
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationWillResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        
        // Observar cuando la app vuelve al foreground
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applicationDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @objc private func applicationWillResignActive() {
        guard let window = self.window else { return }
        
        securityView = UIView(frame: window.bounds)
        securityView?.backgroundColor = .black
        window.addSubview(securityView!)
    }
    
    @objc private func applicationDidBecomeActive() {
        securityView?.removeFromSuperview()
        securityView = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}