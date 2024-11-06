import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Configurar notificación para cuando cambie el estado de captura de pantalla
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleScreenCaptureChange),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Manejar cambios en el estado de captura de pantalla
    @objc func handleScreenCaptureChange() {
        if #available(iOS 13.0, *) {
            guard let screen = window?.windowScene?.screen else { return }
            if screen.isCaptured {
                // Cuando se detecta la captura de pantalla
                addSecureOverlay()
            } else {
                // Cuando se detiene la captura
                removeSecureOverlay()
            }
        }
    }
    
    private func addSecureOverlay() {
        guard let window = self.window else { return }
        let overlayTag = 123456
        
        // Remover overlay existente si existe
        if let existingOverlay = window.viewWithTag(overlayTag) {
            existingOverlay.removeFromSuperview()
        }
        
        // Crear nuevo overlay
        let overlay = UIView(frame: window.bounds)
        overlay.tag = overlayTag
        overlay.backgroundColor = .black
        window.addSubview(overlay)
        window.bringSubviewToFront(overlay)
    }
    
    private func removeSecureOverlay() {
        if let overlay = window?.viewWithTag(123456) {
            overlay.removeFromSuperview()
        }
    }
    
    // Limpiar el observer cuando se cierra la app
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}