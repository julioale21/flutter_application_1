import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private var securityView: UIView?
    private var isSecurityViewVisible = false
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        setupSecurityObservers()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupSecurityObservers() {
        // Observer para capturas de pantalla
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSecurityTrigger),
            name: UIApplication.userDidTakeScreenshotNotification,
            object: nil
        )
        
        // Observer para grabación de pantalla
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSecurityTrigger),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func handleSecurityTrigger() {
        showSecurityScreen()
    }
    
    private func showSecurityScreen() {
        guard !isSecurityViewVisible else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if self.securityView == nil {
                self.securityView = self.createSecurityScreen()
            }
            
            if let securityView = self.securityView,
               let window = self.window {
                securityView.frame = window.bounds
                window.addSubview(securityView)
                window.bringSubviewToFront(securityView)
                
                securityView.alpha = 0
                UIView.animate(withDuration: 0.1) {
                    securityView.alpha = 1
                }
                
                self.isSecurityViewVisible = true
                
                // Auto-ocultar después de un tiempo
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.hideSecurityScreen()
                }
            }
        }
    }
    
    private func hideSecurityScreen() {
        guard isSecurityViewVisible else { return }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let securityView = self.securityView else { return }
            
            UIView.animate(withDuration: 0.1) {
                securityView.alpha = 0
            } completion: { _ in
                securityView.removeFromSuperview()
                self.isSecurityViewVisible = false
            }
        }
    }
    
    private func createSecurityScreen() -> UIView {
        let securityView = UIView()
        securityView.backgroundColor = .white
        
        // Container para el texto
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        securityView.addSubview(container)
        
        // Mensaje principal
        let messageLabel = UILabel()
        messageLabel.text = "Contenido Protegido"
        messageLabel.font = .systemFont(ofSize: 24, weight: .bold)
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(messageLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: securityView.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: securityView.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: securityView.leadingAnchor, constant: 40),
            container.trailingAnchor.constraint(equalTo: securityView.trailingAnchor, constant: -40),
            
            messageLabel.topAnchor.constraint(equalTo: container.topAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return securityView
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        super.applicationWillResignActive(application)
        showSecurityScreen()
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
        hideSecurityScreen()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}