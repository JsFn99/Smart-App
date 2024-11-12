import 'package:flutter/material.dart';
import 'FruitsModelRunner.dart';
import 'ImageSelectionScreen.dart';

class ModelsList extends StatelessWidget {
  final List<String> models = ["Fruit Classification", "Model 2", "Model 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Models"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: models.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(models[index]),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to the correct screen based on the selected model
                if (models[index] == "Fruit Classification") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageSelectionScreen(modelName: models[index]),
                    ),
                  );
                } else if (models[index] == "Model 2") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageSelectionScreen(modelName: models[index]),
                    ),
                  );
                } else if (models[index] == "Model 3") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageSelectionScreen(modelName: models[index]),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
