import 'package:tflite_flutter/tflite_flutter.dart';
import 'ml_service.dart';

class MobileMLService implements MLService {
  Interpreter? _interpreter;

  @override
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('linear.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
      rethrow;
    }
  }

  @override
  double predict(double input) {
    if (_interpreter == null) {
      throw Exception('Model not loaded');
    }

    // Prepare input and output tensors
    var inputData = [input];
    var outputData = List.filled(1, 0.0).reshape([1, 1]);

    // Run inference
    _interpreter!.run(inputData, outputData);

    return outputData[0][0];
  }
}

MLService createMLService() => MobileMLService();
