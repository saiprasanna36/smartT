// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class ViewProductsScreen extends StatelessWidget {
//   const ViewProductsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser; // Get logged-in user
//     if (user == null) {
//       return const Center(child: Text('No user logged in'));
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('View Products')),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .collection('products')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           var products = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var product = products[index].data() as Map<String, dynamic>;
//
//               return ListTile(
//                 title: Text(product['name']),
//                 subtitle: Text('Category: ${product['category']}\nExpiry: ${product['expiry_date']}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }







//ncfb
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// class ViewProductsScreen extends StatelessWidget {
//   const ViewProductsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser; // Get logged-in user
//     if (user == null) {
//       return const Center(child: Text('No user logged in'));
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('View Products')),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .collection('products')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           var products = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var product = products[index].data() as Map<String, dynamic>;
//
//               return ListTile(
//                 title: Text(product['name']),
//                 subtitle: Text('Category: ${product['category']}\nExpiry: ${product['expiry_date']}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }





//noti
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart'; // For date formatting
//
// class ViewProducts extends StatelessWidget {
//   const ViewProducts({super.key});
//
//   // Function to get color based on expiry date
//   Color _getExpiryColor(String expiryDate) {
//     try {
//       DateTime expiry = DateFormat('yyyy-MM-dd').parse(expiryDate);
//       DateTime now = DateTime.now();
//       int daysLeft = expiry.difference(now).inDays;
//
//       if (daysLeft < 0) {
//         return Colors.red.shade300; // Expired
//       } else if (daysLeft <= 5) {
//         return Colors.orange.shade300; // Expiring soon
//       } else {
//         return Colors.green.shade300; // Safe
//       }
//     } catch (e) {
//       return Colors.grey.shade300; // Default color for invalid dates
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser; // Get logged-in user
//     if (user == null) {
//       return const Center(child: Text('No user logged in'));
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('View Products')),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .collection('products')
//             .orderBy('expiry_date') // Sorting by expiry date
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           var products = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var product = products[index].data() as Map<String, dynamic>;
//               Color expiryColor = _getExpiryColor(product['expiry_date']);
//
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: expiryColor, // Background color based on expiry date
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     product['name'],
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     'Category: ${product['category']}\nExpiry: ${product['expiry_date']}',
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




//noti1
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
// class ViewProducts extends StatelessWidget {
//   const ViewProducts({super.key});
//
//   // Function to parse date with multiple formats
//   DateTime? _parseDate(String date) {
//     List<String> formats = ['yyyy-MM-dd', 'dd/MM/yyyy', 'MM/dd/yyyy'];
//
//     for (String format in formats) {
//       try {
//         return DateFormat(format).parseStrict(date);
//       } catch (e) {
//         continue;
//       }
//     }
//     return null;
//   }
//
//   Color _getExpiryColor(String expiryDate) {
//     DateTime now = DateTime.now();
//     DateTime? expiry = _parseDate(expiryDate);
//
//     if (expiry == null) {
//       return Colors.grey.shade300; // Default color for invalid dates
//     }
//
//     int daysLeft = expiry.difference(now).inDays;
//
//     if (daysLeft < 0) {
//       return Colors.red.shade300; // Expired
//     } else if (daysLeft <= 5) {
//       return Colors.orange.shade300; // Expiring soon
//     } else {
//       return Colors.green.shade300; // Safe
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return const Center(child: Text('No user logged in'));
//     }
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('View Products')),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .collection('products')
//             .orderBy('expiry_date')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           var products = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var product = products[index].data() as Map<String, dynamic>;
//               Color expiryColor = _getExpiryColor(product['expiry_date']);
//
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: expiryColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ListTile(
//                   title: Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Text('Category: ${product['category']}\nExpiry: ${product['expiry_date']}'),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//








//noticat
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
//
// class ViewProducts extends StatefulWidget {
//   const ViewProducts({super.key});
//
//   @override
//   _ViewProductsState createState() => _ViewProductsState();
// }
//
// class _ViewProductsState extends State<ViewProducts> {
//   String? selectedCategory;
//
//   // Function to parse date with multiple formats
//   DateTime? _parseDate(String date) {
//     List<String> formats = ['yyyy-MM-dd', 'dd/MM/yyyy', 'MM/dd/yyyy'];
//     for (String format in formats) {
//       try {
//         return DateFormat(format).parseStrict(date);
//       } catch (e) {
//         continue;
//       }
//     }
//     return null;
//   }
//
//   // Determine background color based on expiry date
//   Color _getExpiryColor(String expiryDate) {
//     DateTime now = DateTime.now();
//     DateTime? expiry = _parseDate(expiryDate);
//     if (expiry == null) return Colors.grey.shade200; // Default for invalid dates
//
//     int daysLeft = expiry.difference(now).inDays;
//     if (daysLeft < 0) return Colors.red.shade400; // Expired
//     if (daysLeft <= 5) return Colors.orange.shade300; // Expiring soon
//     return Colors.green.shade300; // Safe
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return const Scaffold(body: Center(child: Text('No user logged in')));
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(selectedCategory == null ? 'Categories' : selectedCategory!),
//         leading: selectedCategory == null
//             ? null
//             : IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => setState(() => selectedCategory = null),
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .collection('products')
//             .orderBy('category')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           var products = snapshot.data!.docs;
//           Map<String, List<Map<String, dynamic>>> categoryMap = {};
//
//           // Group products by category
//           for (var product in products) {
//             var data = product.data() as Map<String, dynamic>;
//             String category = data['category'] ?? 'Uncategorized';
//             categoryMap.putIfAbsent(category, () => []).add(data);
//           }
//
//           // Show category list if no category is selected
//           if (selectedCategory == null) {
//             return ListView(
//               children: categoryMap.keys.map((category) {
//                 return Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                   color: Colors.blue.shade200,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   child: ListTile(
//                     title: Text(
//                       category,
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                     onTap: () => setState(() => selectedCategory = category),
//                   ),
//                 );
//               }).toList(),
//             );
//           }
//
//           // Show products under the selected category
//           return ListView(
//             children: categoryMap[selectedCategory]!.map((product) {
//               Color expiryColor = _getExpiryColor(product['expiry_date']);
//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                 color: expiryColor,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: ListTile(
//                   title: Text(
//                     product['name'],
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   subtitle: Text('Expiry: ${product['expiry_date']}'),
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }


//UI
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({super.key});

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  String? selectedCategory;

  // Function to parse date with multiple formats
  DateTime? _parseDate(String date) {
    List<String> formats = ['yyyy-MM-dd', 'dd/MM/yyyy', 'MM/dd/yyyy'];
    for (String format in formats) {
      try {
        return DateFormat(format).parseStrict(date);
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  // Determine background color based on expiry date
  Color _getExpiryColor(String expiryDate) {
    DateTime now = DateTime.now();
    DateTime? expiry = _parseDate(expiryDate);
    if (expiry == null) return Colors.grey.shade200; // Default for invalid dates

    int daysLeft = expiry.difference(now).inDays;
    if (daysLeft < 0) return Colors.red.shade400; // Expired
    if (daysLeft <= 5) return Colors.orange.shade300; // Expiring soon
    return Colors.green.shade300; // Safe
  }

  // Function to delete product
  Future<void> _deleteProduct(String docId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('products')
          .doc(docId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('No user logged in')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory == null ? 'Categories' : selectedCategory!),
        leading: selectedCategory == null
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => setState(() => selectedCategory = null),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .orderBy('category')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var products = snapshot.data!.docs;
          Map<String, List<Map<String, dynamic>>> categoryMap = {};

          // Group products by category (case-insensitive)
          for (var product in products) {
            var data = product.data() as Map<String, dynamic>;
            String rawCategory = data['category'] ?? 'Uncategorized';
            String category = rawCategory.trim().toLowerCase(); // Normalize category names
            category = category[0].toUpperCase() + category.substring(1); // Capitalize first letter

            categoryMap.putIfAbsent(category, () => []).add({
              ...data,
              'id': product.id, // Store document ID for deletion
            });
          }

          // Show category list if no category is selected
          if (selectedCategory == null) {
            return ListView(
              children: categoryMap.keys.map((category) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  color: Colors.blue.shade200,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    title: Text(
                      category,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => setState(() => selectedCategory = category),
                  ),
                );
              }).toList(),
            );
          }

          // Show products under the selected category
          return ListView(
            children: categoryMap[selectedCategory]!.map((product) {
              Color expiryColor = _getExpiryColor(product['expiry_date']);
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                color: expiryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(
                    product['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text('Expiry: ${product['expiry_date']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteProduct(product['id']);
                    },
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
