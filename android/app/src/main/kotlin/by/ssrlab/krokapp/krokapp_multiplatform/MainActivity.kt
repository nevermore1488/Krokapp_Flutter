package by.ssrlab.krokapp.krokapp_multiplatform

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import com.yandex.mapkit.MapKitFactory;
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("94c6f442-d565-4970-aa0c-cb6174d854b9") // Your generated API key
        super.configureFlutterEngine(flutterEngine)
    }
}
