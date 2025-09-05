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
//   // Function to pick a date manually
//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _expiryDateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
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
//               decoration: const InputDecoration(
//                 labelText: 'Expiry Date',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.calendar_today),
//               ),
//               readOnly: true,
//               onTap: () => _selectDate(context), // Open date picker on tap
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



//noti exp barcode
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'notification_service.dart';
// import 'barcode_scanner_screen.dart';
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
//   final _expiryDateController = TextEditingController();
//   String _selectedCategory = '';
//   DateTime? _selectedExpiryDate;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Predefined categories for dropdown
//   final List<String> _categories = [
//     'Beverages', 'Snacks', 'Dairy', 'Bakery', 'Meat',
//     'Frozen', 'Produce', 'Pantry', 'Personal Care', 'Household'
//   ];
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _expiryDateController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _selectedCategory.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }
//
//     try {
//       await _firestore.collection('users').doc(user.uid).collection('products').add({
//         'name': _nameController.text,
//         'category': _selectedCategory,
//         'expiry_date': _expiryDateController.text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
// try {
// DateTime expiryDate = DateFormat('yyyy-MM-dd').parse(_expiryDateController.text);
// NotificationService.scheduleNotification(_nameController.text, expiryDate);
// } catch (e) {
// print('Failed to parse expiry date: $e');
// }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product added successfully')),
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }
//
//   // Function to scan expiry date using camera
//   Future<void> _scanExpiryDate() async {
//     final scannedDate = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ExpiryScanner()),
//     );
//
//     if (scannedDate != null && scannedDate is String) {
//       setState(() {
//         _expiryDateController.text = scannedDate; // Auto-fill expiry date
//       });
//     }
//   }
//
//   // Function to pick expiry date manually
//   Future<void> _selectExpiryDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedExpiryDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _selectedExpiryDate = pickedDate;
//         _expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//       });
//     }
//   }
//
//   // Function to scan barcode and fetch product details
//   Future<void> _scanBarcodeAndFetchProduct() async {
//     final barcode = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
//     );
//
//     if (barcode != null && barcode is String) {
//       await _fetchProductFromOpenFoodFacts(barcode);
//     }
//   }
//
//   // Function to fetch product details from Open Food Facts API
//   Future<void> _fetchProductFromOpenFoodFacts(String barcode) async {
//     final String apiUrl = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
//
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//
//         if (data['status'] == 1) {
//           String productName = data['product']['product_name'] ?? 'Unknown Product';
//
//           List<dynamic> categoriesTags = data['product']['categories_tags'] ?? [];
//           String productCategory = '';
//           if (categoriesTags.isNotEmpty) {
//             productCategory = categoriesTags[0].toString().replaceAll('en:', '');
//           }
//
//           setState(() {
//             _nameController.text = productName;
//
//             if (_categories.contains(productCategory)) {
//               _selectedCategory = productCategory;
//             } else {
//               _selectedCategory = '';
//             }
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Product found: $productName')),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Product not found in Open Food Facts.')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${response.reasonPhrase}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to fetch product info: $e')),
//       );
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
//               decoration: const InputDecoration(
//                 labelText: 'Product Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: const InputDecoration(
//                 labelText: 'Select Category',
//                 border: OutlineInputBorder(),
//               ),
//               value: _selectedCategory.isNotEmpty ? _selectedCategory : null,
//               items: _categories.map((category) {
//                 return DropdownMenuItem<String>(
//                   value: category,
//                   child: Text(category),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCategory = value!;
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Select Expiry Date',
//                 border: const OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: () => _selectExpiryDate(context),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: _scanExpiryDate,
//               icon: const Icon(Icons.qr_code_scanner),
//               label: const Text("Scan Expiry Date"),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               onPressed: _scanBarcodeAndFetchProduct,
//               icon: const Icon(Icons.qr_code_scanner),
//               label: const Text('Scan Barcode'),
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





//UI
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'notification_service.dart';
import 'barcode_scanner_screen.dart';
import 'expiry_scanner.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _quantityController = TextEditingController();
  String _selectedCategory = '';
  DateTime? _selectedExpiryDate;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> _categories = [
    'Beverages', 'Snacks', 'Dairy', 'Bakery', 'Meat',
    'Frozen', 'Produce','Fruits','Vegetables'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _expiryDateController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _addProduct() async {
    final user = _auth.currentUser;
    if (user == null) return;

    if (_nameController.text.isEmpty ||
        _selectedCategory.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      await _firestore.collection('users').doc(user.uid).collection('products').add({
        'name': _nameController.text,
        'category': _selectedCategory,
        'expiry_date': _expiryDateController.text,
        'quantity': _quantityController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // ✅ Schedule Notification for Expiry Date
      if (_expiryDateController.text.isNotEmpty) {
        try {
          // Parse the expiry date
          DateTime expiryDate = DateFormat('yyyy-MM-dd').parse(_expiryDateController.text);

          // Calculate days left until expiry
          int daysLeft = expiryDate.difference(DateTime.now()).inDays;

          // Parse quantity safely
          int quantity = int.tryParse(_quantityController.text) ?? 1;

          // Call scheduleNotification with correct parameters
          NotificationService.scheduleNotification(
              _nameController.text, // Product Name (String)
              daysLeft,             // Days Left until expiry (int)
              quantity              // Quantity (int)
          );
        } catch (e) {
          print("Error scheduling notification: $e");
        }

      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _scanExpiryDate() async {
    final scannedDate = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpiryScanner()),
    );

    if (scannedDate != null && scannedDate is String) {
      setState(() {
        _expiryDateController.text = scannedDate;
      });
    }
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedExpiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedExpiryDate = pickedDate;
        _expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _scanBarcodeAndFetchProduct() async {
    final barcode = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
    );

    if (barcode != null && barcode is String) {
      await _fetchProductFromOpenFoodFacts(barcode);
    }
  }

  Future<void> _fetchProductFromOpenFoodFacts(String barcode) async {
    final String apiUrl = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 1) {
          String productName = data['product']['product_name'] ?? 'Unknown Product';
          List<dynamic> categoriesTags = data['product']['categories_tags'] ?? [];
          String productCategory = '';
          String quantity = data['product']['quantity'] ?? '';

          if (categoriesTags.isNotEmpty) {
            productCategory = categoriesTags[0].toString().replaceAll('en:', '');
          }

          setState(() {
            _nameController.text = productName;
            _quantityController.text = quantity.isNotEmpty ? quantity : '';

            if (_categories.contains(productCategory)) {
              _selectedCategory = productCategory;
            } else {
              _selectedCategory = '';
            }
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product found: $productName')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product not found in Open Food Facts.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch product info: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Product Name', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Select Category', border: OutlineInputBorder()),
                      value: _selectedCategory.isNotEmpty ? _selectedCategory : null,
                      items: _categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Quantity', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _expiryDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Select Expiry Date',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectExpiryDate(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _scanBarcodeAndFetchProduct,
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scan Barcode'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _scanExpiryDate,
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scan Expiry Date'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addProduct,
                      child: const Text('Add Product'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








//n e b 1
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'barcode_scanner_screen.dart';
// import 'expiry_scanner.dart';
// import 'notification_service.dart'; // Import notification service
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
//   final _expiryDateController = TextEditingController();
//   String _selectedCategory = '';
//   DateTime? _selectedExpiryDate;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final List<String> _categories = [
//     'Beverages', 'Snacks', 'Dairy', 'Bakery', 'Meat',
//     'Frozen', 'Produce', 'Pantry', 'Personal Care', 'Household'
//   ];
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _expiryDateController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _addProduct() async {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     if (_nameController.text.isEmpty || _selectedCategory.isEmpty || _expiryDateController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields')),
//       );
//       return;
//     }
//
//     try {
//       await _firestore.collection('users').doc(user.uid).collection('products').add({
//         'name': _nameController.text,
//         'category': _selectedCategory,
//         'expiry_date': _expiryDateController.text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//
//       // Convert expiry date to DateTime for scheduling notification
//       try {
//         DateTime expiryDate = DateFormat('yyyy-MM-dd').parse(_expiryDateController.text);
//         NotificationService.scheduleNotification(_nameController.text, expiryDate);
//       } catch (e) {
//         print('Failed to parse expiry date: $e');
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Product added successfully')),
//       );
//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }
//
//   Future<void> _selectExpiryDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedExpiryDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _selectedExpiryDate = pickedDate;
//         _expiryDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
//               decoration: const InputDecoration(
//                 labelText: 'Product Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: const InputDecoration(
//                 labelText: 'Select Category',
//                 border: OutlineInputBorder(),
//               ),
//               value: _selectedCategory.isNotEmpty ? _selectedCategory : null,
//               items: _categories.map((category) {
//                 return DropdownMenuItem<String>(
//                   value: category,
//                   child: Text(category),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedCategory = value!;
//                 });
//               },
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _expiryDateController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Select Expiry Date',
//                 border: const OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.calendar_today),
//                   onPressed: () => _selectExpiryDate(context),
//                 ),
//               ),
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
