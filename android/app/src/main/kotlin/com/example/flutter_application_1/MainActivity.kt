package com.example.flutter_application_1

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.view.WindowManager

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Previene capturas de pantalla y grabación de pantalla
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
        
        // Opcional: Prevenir que se muestre el contenido en el switcher de apps recientes
        window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
    }
}