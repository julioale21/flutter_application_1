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
        
        // Solo observar screenshots
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleScreenshot),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @objc private func handleScreenshot() {
        guard let window = self.window else { return }
        
        let view = UIView(frame: window.bounds)
        view.backgroundColor = .white
        window.addSubview(view)
        
        // Remover después de un breve momento
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            view.removeFromSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}