//1
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser; // Get current user
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _categoryController.text.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//
//     await _firestore.collection('users').doc(user.uid).collection('products').add({
//       'name': _nameController.text,
//       'category': _categoryController.text,
//       'expiry_date': _expiryDateController.text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               decoration: const InputDecoration(labelText: 'Expiry Date', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addProduct,
//               child: const Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




//2 noti
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'notification_service.dart'; // Import Notification Service
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final NotificationService _notificationService = NotificationService(); // Initialize notification service
//
//   Future<void> _pickExpiryDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)), // Up to 1 year
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _expiryDateController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
//       });
//     }
//   }
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _categoryController.text.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//
//     // Parse expiry date and schedule notification 5 days before
//     DateTime expiryDate = DateFormat("dd-MM-yyyy").parse(_expiryDateController.text);
//     DateTime notifyDate = expiryDate.subtract(const Duration(days: 5));
//
//     await _firestore.collection('users').doc(user.uid).collection('products').add({
//       'name': _nameController.text,
//       'category': _categoryController.text,
//       'expiry_date': _expiryDateController.text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     // Schedule local notification
//     await _notificationService.scheduleNotification(
//       0, // Unique ID for the notification
//       "Expiry Reminder!",
//       "${_nameController.text} is expiring soon!",
//       notifyDate,
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               readOnly: true,
//               decoration: const InputDecoration(
//                 labelText: 'Expiry Date',
//                 border: OutlineInputBorder(),
//               ),
//               onTap: _pickExpiryDate, // Show date picker
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addProduct,
//               child: const Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





//3 expiry date
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'notification_service.dart'; // Import Notification Service
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final NotificationService _notificationService = NotificationService();
//
//   Future<void> _scanExpiryDate() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//     if (image == null) return;
//
//     final inputImage = InputImage.fromFile(File(image.path));
//     final textRecognizer = GoogleMlKit.vision.textRecognizer();
//
//     try {
//       final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
//
//       for (TextBlock block in recognizedText.blocks) {
//         for (TextLine line in block.lines) {
//           if (RegExp(r'\b\d{2}[-/]\d{2}[-/]\d{4}\b').hasMatch(line.text)) {
//             String extractedDate = line.text;
//             extractedDate = extractedDate.replaceAll('/', '-'); // Normalize format
//             _expiryDateController.text = extractedDate;
//             setState(() {});
//             return;
//           }
//         }
//       }
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No expiry date found. Try again.')));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     } finally {
//       textRecognizer.close();
//     }
//   }
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _categoryController.text.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//
//     DateTime expiryDate = DateFormat("dd-MM-yyyy").parse(_expiryDateController.text);
//     DateTime notifyDate = expiryDate.subtract(const Duration(days: 5));
//
//     await _firestore.collection('users').doc(user.uid).collection('products').add({
//       'name': _nameController.text,
//       'category': _categoryController.text,
//       'expiry_date': _expiryDateController.text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     await _notificationService.scheduleNotification(
//       0, "Expiry Reminder!", "${_nameController.text} is expiring soon!", notifyDate,
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               readOnly: true,
//               decoration: const InputDecoration(labelText: 'Expiry Date', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _scanExpiryDate,
//               child: const Text('Scan Expiry Date'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addProduct,
//               child: const Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












//nandini
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'expiry_scanner.dart'; // Import expiry scanner
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _categoryController.text.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//
//     await _firestore.collection('users').doc(user.uid).collection('products').add({
//       'name': _nameController.text,
//       'category': _categoryController.text,
//       'expiry_date': _expiryDateController.text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
//     Navigator.pop(context);
//   }
//
//   // Function to open expiry scanner and get expiry date
//   Future<void> _scanExpiryDate() async {
//     final scannedDate = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ExpiryScanner()),
//     );
//
//     if (scannedDate != null && scannedDate is String) {
//       setState(() {
//         _expiryDateController.text = scannedDate; // Auto-fill expiry date field
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               decoration: const InputDecoration(labelText: 'Expiry Date', border: OutlineInputBorder()),
//               readOnly: true, // Read-only since we scan the expiry date
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _scanExpiryDate,
//               child: const Text("Scan Expiry Date"),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addProduct,
//               child: const Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











//newcodefb
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'expiry_scanner.dart'; // Import expiry scanner
//
// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});
//
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final _nameController = TextEditingController();
//   final _categoryController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _categoryController.text.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//
//     await _firestore.collection('users').doc(user.uid).collection('products').add({
//       'name': _nameController.text,
//       'category': _categoryController.text,
//       'expiry_date': _expiryDateController.text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
//     Navigator.pop(context);
//   }
//
//   // Function to open expiry scanner and get expiry date
//   Future<void> _scanExpiryDate() async {
//     final scannedDate = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ExpiryScanner()),
//     );
//
//     if (scannedDate != null && scannedDate is String) {
//       setState(() {
//         _expiryDateController.text = scannedDate; // Auto-fill expiry date field
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Product')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _categoryController,
//               decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               decoration: const InputDecoration(labelText: 'Expiry Date', border: OutlineInputBorder()),
//               readOnly: true, // Read-only since we scan the expiry date
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _scanExpiryDate,
//               child: const Text("Scan Expiry Date"),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _addProduct,
//               child: const Text('Add Product'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





//noti
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'expiry_scanner.dart'; // Import expiry scanner

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _expiryDateController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addProduct() async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (_nameController.text.isEmpty || _categoryController.text.isEmpty || _expiryDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    await _firestore.collection('users').doc(user.uid).collection('products').add({
      'name': _nameController.text,
      'category': _categoryController.text,
      'expiry_date': _expiryDateController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added successfully')));
    Navigator.pop(context);
  }

  // Function to open expiry scanner and get expiry date
  Future<void> _scanExpiryDate() async {
    final scannedDate = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpiryScanner()),
    );

    if (scannedDate != null && scannedDate is String) {
      setState(() {
        _expiryDateController.text = scannedDate; // Auto-fill expiry date field
      });
    }
  }

  // Function to pick a date manually
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _expiryDateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _expiryDateController,
              decoration: const InputDecoration(
                labelText: 'Expiry Date',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context), // Open date picker on tap
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _scanExpiryDate,
              child: const Text("Scan Expiry Date"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
