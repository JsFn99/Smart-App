import 'dart:io';
import 'package:flutter/material.dart';

class ModelRunner extends StatelessWidget {
  final String modelName;
  final File image;

  const ModelRunner({Key? key, required this.modelName, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Running $modelName'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(image),
            SizedBox(height: 20),
            Text("Processing..."),
            // Add your model processing logic here.
          ],
        ),
      ),
    );
  }
}
