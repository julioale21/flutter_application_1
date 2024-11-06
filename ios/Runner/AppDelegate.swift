import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var securityView: UIView?
    private var isCapturing = false
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Observer para cuando se inicia la captura
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willTakeScreenshot),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
        
        createSecurityView()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func createSecurityView() {
        securityView = UIView(frame: window?.bounds ?? .zero)
        securityView?.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Contenido Protegido"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        securityView?.addSubview(label)
        
        if let securityView = securityView {
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: securityView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: securityView.centerYAnchor)
            ])
        }
    }
    
    @objc private func willTakeScreenshot() {
        guard !isCapturing else { return }
        isCapturing = true
        
        // Mostrar la vista de seguridad inmediatamente
        if let securityView = securityView, let window = self.window {
            securityView.frame = window.bounds
            window.addSubview(securityView)
            window.bringSubviewToFront(securityView)
            
            // Mantener la vista de seguridad por más tiempo
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                securityView.removeFromSuperview()
                self?.isCapturing = false
            }
        }
    }
    
    // Asegurar que la vista de seguridad se muestre también al entrar en background
    override func applicationWillResignActive(_ application: UIApplication) {
        super.applicationWillResignActive(application)
        willTakeScreenshot()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}