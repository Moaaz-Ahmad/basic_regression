import 'ml_service.dart';

class WebMLService implements MLService {
  bool _isLoaded = false;

  @override
  Future<void> loadModel() async {
    // Simulate model loading for web platform
    await Future.delayed(Duration(milliseconds: 500));
    _isLoaded = true;
    print('Web ML service initialized - TensorFlow Lite model not available on web');
    print('Note: For production web apps, consider using TensorFlow.js or server-side inference');
  }

  @override
  double predict(double input) {
    if (!_isLoaded) {
      throw Exception('Web ML service not initialized');
    }

    // For web platform, we'll provide a message indicating the limitation
    // In a real application, you would either:
    // 1. Use TensorFlow.js to run the model in the browser
    // 2. Make HTTP requests to a server that runs the TensorFlow Lite model
    // 3. Convert the model to a web-compatible format

    // For now, we'll throw an exception with a helpful message
    throw Exception('TensorFlow Lite models are not supported on web platform. '
        'Please use the mobile app for ML predictions or implement TensorFlow.js support.');
  }
}

MLService createMLService() => WebMLService();
