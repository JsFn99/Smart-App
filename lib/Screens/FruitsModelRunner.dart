import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class FruitsModelRunner extends StatefulWidget {
  @override
  _FruitsModelRunnerState createState() => _FruitsModelRunnerState();
}

class _FruitsModelRunnerState extends State<FruitsModelRunner> {
  bool _isLoading = true;
  List<String> labels = ["apple", "banana", "orange"];
  String? _predictionLabel;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    await Tflite.loadModel(
      model: "assets/Fruits.tflite",
    );
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _runModelPrediction(String imagePath) async {
    var recognitions = await Tflite.runModelOnImage(
      path: imagePath,
      imageMean: 0.0,
      imageStd: 255.0,
      numResults: 1,
      threshold: 0.5,
    );

    setState(() {
      if (recognitions != null && recognitions.isNotEmpty) {
        int labelIndex = recognitions[0]["index"];
        _predictionLabel = labels[labelIndex];
      } else {
        _predictionLabel = "No prediction found";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fruit Prediction")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_predictionLabel ?? "No prediction made yet", style: TextStyle(fontSize: 20)),
          ElevatedButton(
            onPressed: () async {
              // Replace this with actual image picking logic
              String imagePath = "path_to_your_image";
              await _runModelPrediction(imagePath);
            },
            child: Text("Run Prediction"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
