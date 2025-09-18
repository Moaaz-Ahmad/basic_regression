// Platform-conditional imports
import 'ml_service_mobile.dart' if (dart.library.html) 'ml_service_web.dart';

// Platform-agnostic interface
abstract class MLService {
  Future<void> loadModel();
  double predict(double input);

  // Factory constructor that returns the appropriate implementation
  factory MLService() {
    // This will be conditionally imported
    return createMLService();
  }
}
