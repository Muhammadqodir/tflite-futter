import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _result = "";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Load the TFLite model
  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/last_float32.tflite",
      // labels: "assets/labels.txt", // Optional: provide labels if you have them
    );
    print(res);
  }

  // Run inference
  Future<void> runModel() async {
    var output = await Tflite.runModelOnImage(
      path: "path_to_image.jpg", // Path to your input image
      numResults: 2,
      threshold: 0.5,
    );
    setState(() {
      _result = output.toString();
    });
    print(output);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TFLite Model')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Model Result: $_result'),
            ElevatedButton(
              onPressed: runModel,
              child: Text('Run Model'),
            ),
          ],
        ),
      ),
    );
  }
}