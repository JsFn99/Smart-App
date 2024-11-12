import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import '../Widgets/FruitResult.dart';

class ImageSelectionScreen extends StatefulWidget {
  final String modelName;

  const ImageSelectionScreen({Key? key, required this.modelName}) : super(key: key);

  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isProcessing = false;
  String? fruit;
  double? probability;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _sendImageToApi(_image!);
    }
  }

  Future<void> _sendImageToApi(File image) async {
    setState(() {
      isProcessing = true;
      fruit = null;
      probability = null;
    });

    try {
      final uri = Uri.parse('http://10.0.2.2:8080/predict');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
          'file', image.path,
          contentType: MediaType('image', 'jpeg'),
        ));

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final result = json.decode(responseData);
        setState(() {
          fruit = result['fruit'];
          probability = result['probability'];
        });
      } else {
        setState(() {
          fruit = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        fruit = 'Error: $e';
      });
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.modelName}'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text("Take a Picture"),
                ),
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: Icon(Icons.photo),
                  label: Text("Load from Gallery"),
                ),
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _image!,
                      height: 200,
                    ),
                  ),
                if (isProcessing)
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                if (fruit != null && probability != null)
                  PredictionResultDisplay(fruit: fruit!, probability: probability!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
