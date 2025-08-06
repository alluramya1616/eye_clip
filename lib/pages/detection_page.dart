import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/glassmorphic_container.dart';
import '../widgets/custom_button.dart';

class DetectionPage extends StatefulWidget {
  @override
  _DetectionPageState createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Glaucoma Detection')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GlassmorphicContainer(
              height: 300,
              child: Center(
                child: _image == null
                    ? Text('No image selected')
                    : Image.file(_image!),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: 'Pick from Gallery',
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
                CustomButton(
                  text: 'Capture with Camera',
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              text: 'Detect & Classify',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Model logic coming soon!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
