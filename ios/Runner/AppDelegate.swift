import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var secureWindow: UIWindow?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // Crear una ventana segura sobre la ventana principal
        if let mainWindow = self.window {
            secureWindow = UIWindow(frame: mainWindow.bounds)
            secureWindow?.windowLevel = .alert + 1
            secureWindow?.rootViewController = SecureViewController()
            secureWindow?.isHidden = true
            
            // Observar capturas de pantalla
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(screenCaptureWillBegin),
                name: UIScreen.capturedDidChangeNotification,
                object: nil
            )
            
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(screenCaptureWillBegin),
                name: UIApplication.userDidTakeScreenshotNotification,
                object: nil
            )
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @objc private func screenCaptureWillBegin() {
        secureWindow?.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.secureWindow?.isHidden = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// Controlador para la ventana segura
class SecureViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Contenido Protegido"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Prevenir grabación de pantalla
        let textField = UITextField()
        textField.isSecureTextEntry = true
        view.addSubview(textField)
    }
}