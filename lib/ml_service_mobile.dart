import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'ml_service.dart';

class MobileMLService implements MLService {
  Interpreter? _interpreter;

  @override
  Future<void> loadModel() async {
    try {
      // Load the asset data as bytes
      final ByteData assetData = await rootBundle.load('assets/linear.tflite');
      final Uint8List bytes = assetData.buffer.asUint8List();
      print('Asset loaded successfully: ${bytes.length} bytes');

      // Create interpreter from bytes
      _interpreter = Interpreter.fromBuffer(bytes);
      print('TensorFlow Lite model loaded successfully');
    } catch (e) {
      print('Error loading TensorFlow Lite model: $e');
      rethrow;
    }
  }

  @override
  double predict(double input) {
    if (_interpreter == null) {
      throw Exception('TensorFlow Lite model not loaded');
    }

    try {
      // Prepare input tensor - reshape to match model input shape [1, 1]
      var inputData = [[input]];

      // Prepare output tensor - create a 2D array to match output shape [1, 1]
      var outputData = List.generate(1, (_) => List.filled(1, 0.0));

      // Run inference with the TensorFlow Lite model
      _interpreter!.run(inputData, outputData);

      // Return the prediction result
      return outputData[0][0];
    } catch (e) {
      print('Error during prediction: $e');
      throw Exception('Prediction failed: $e');
    }
  }
}

MLService createMLService() => MobileMLService();
