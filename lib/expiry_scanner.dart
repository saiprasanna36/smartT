// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
//
// class ExpiryScanner extends StatefulWidget {
//   @override
//   _ExpiryScannerState createState() => _ExpiryScannerState();
// }
//
// class _ExpiryScannerState extends State<ExpiryScanner> {
//   File? _image; // Holds the selected image
//   String _scannedText = ""; // Holds the scanned expiry date
//
//   // Function to pick an image (camera/gallery)
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _extractText();
//     }
//   }
//
//   // Function to extract text using OCR
//   Future<void> _extractText() async {
//     if (_image == null) return;
//
//     final inputImage = InputImage.fromFile(_image!);
//     final textDetector = GoogleMlKit.vision.textRecognizer();
//
//     try {
//       final RecognizedText recognizedText = await textDetector.processImage(inputImage);
//       textDetector.close(); // Close the detector after use
//
//       String extractedText = recognizedText.text;
//       print("Extracted Text: $extractedText");
//
//       // Extract expiry date using regex
//       String expiryDate = _extractExpiryDate(extractedText);
//
//       if (expiryDate.isNotEmpty) {
//         Navigator.pop(context, expiryDate); // Return scanned expiry date
//       } else {
//         setState(() {
//           _scannedText = "No expiry date found!";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _scannedText = "Error reading text.";
//       });
//       print("Error: $e");
//     }
//   }
//
//   // Function to extract expiry date from text
//   String _extractExpiryDate(String text) {
//     RegExp regex = RegExp(
//       r'(\b\d{1,2}[\/\.-]\d{1,2}[\/\.-]\d{2,4}\b|\b\d{2,4}[\/\.-]\d{1,2}[\/\.-]\d{1,2}\b)',
//       caseSensitive: false,
//     );
//     Match? match = regex.firstMatch(text);
//     return match != null ? match.group(0)! : "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Scan Expiry Date")),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _image != null ? Image.file(_image!) : Text("No image selected"),
//           SizedBox(height: 10),
//           Text(_scannedText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () => _pickImage(ImageSource.camera),
//                 child: Text("Capture Image"),
//               ),
//               ElevatedButton(
//                 onPressed: () => _pickImage(ImageSource.gallery),
//                 child: Text("Select from Gallery"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }








//ncfb
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ExpiryScanner extends StatefulWidget {
  @override
  _ExpiryScannerState createState() => _ExpiryScannerState();
}

class _ExpiryScannerState extends State<ExpiryScanner> {
  File? _image; // Holds the selected image
  String _scannedText = ""; // Holds the scanned expiry date

  // Function to pick an image (camera/gallery)
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _extractText();
    }
  }

  // Function to extract text using OCR
  Future<void> _extractText() async {
    if (_image == null) return;

    final inputImage = InputImage.fromFile(_image!);
    final textDetector = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText = await textDetector.processImage(inputImage);
      textDetector.close(); // Close the detector after use

      String extractedText = recognizedText.text;
      print("Extracted Text: $extractedText");

      // Extract expiry date using regex
      String expiryDate = _extractExpiryDate(extractedText);

      if (expiryDate.isNotEmpty) {
        Navigator.pop(context, expiryDate); // Return scanned expiry date
      } else {
        setState(() {
          _scannedText = "No expiry date found!";
        });
      }
    } catch (e) {
      setState(() {
        _scannedText = "Error reading text.";
      });
      print("Error: $e");
    }
  }

  // Function to extract expiry date from text
  String _extractExpiryDate(String text) {
    RegExp regex = RegExp(
      r'(\b\d{1,2}[\/\.-]\d{1,2}[\/\.-]\d{2,4}\b|\b\d{2,4}[\/\.-]\d{1,2}[\/\.-]\d{1,2}\b)',
      caseSensitive: false,
    );
    Match? match = regex.firstMatch(text);
    return match != null ? match.group(0)! : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan Expiry Date")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image != null ? Image.file(_image!) : Text("No image selected"),
          SizedBox(height: 10),
          Text(_scannedText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text("Capture Image"),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text("Select from Gallery"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




