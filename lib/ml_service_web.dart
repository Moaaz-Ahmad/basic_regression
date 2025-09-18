import 'ml_service.dart';

class WebMLService implements MLService {
  bool _isLoaded = false;

  @override
  Future<void> loadModel() async {
    // Simulate loading delay
    await Future.delayed(Duration(milliseconds: 100));
    _isLoaded = true;
    print('Web fallback model loaded');
  }

  @override
  double predict(double input) {
    if (!_isLoaded) {
      throw Exception('Model not loaded');
    }

    // Simple linear approximation for demonstration
    // This would normally be replaced with a web-compatible ML solution
    // like TensorFlow.js or a server-side prediction
    return input * 2.5 + 1.0; // Simple linear function as fallback
  }
}

MLService createMLService() => WebMLService();
