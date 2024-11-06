import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var securityView: UIView?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        setupScreenshotPrevention()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupScreenshotPrevention() {
        // Crear la vista de seguridad
        let securityView = UIView()
        securityView.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Contenido Protegido"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        securityView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: securityView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: securityView.centerYAnchor)
        ])
        
        self.securityView = securityView
        
        // Configurar la prevención
        if let window = self.window {
            window.makeSecure()
        }
    }
}

// Extensión para hacer la ventana segura
extension UIWindow {
    func makeSecure() {
        // Prevenir capturas de pantalla
        DispatchQueue.main.async {
            self.isHidden = false
            self.layer.superlayer?.addSublayer(CALayer())
            self.layer.speed = 0.0
            
            // Esto hace que la captura de pantalla muestre un fondo negro
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            
            field.layer.isHidden = true
        }
    }
}