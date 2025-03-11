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
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting

class ViewProducts extends StatelessWidget {
  const ViewProducts({super.key});

  // Function to get color based on expiry date
  Color _getExpiryColor(String expiryDate) {
    try {
      DateTime expiry = DateFormat('yyyy-MM-dd').parse(expiryDate);
      DateTime now = DateTime.now();
      int daysLeft = expiry.difference(now).inDays;

      if (daysLeft < 0) {
        return Colors.red.shade300; // Expired
      } else if (daysLeft <= 5) {
        return Colors.orange.shade300; // Expiring soon
      } else {
        return Colors.green.shade300; // Safe
      }
    } catch (e) {
      return Colors.grey.shade300; // Default color for invalid dates
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // Get logged-in user
    if (user == null) {
      return const Center(child: Text('No user logged in'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('View Products')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('products')
            .orderBy('expiry_date') // Sorting by expiry date
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index].data() as Map<String, dynamic>;
              Color expiryColor = _getExpiryColor(product['expiry_date']);

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: expiryColor, // Background color based on expiry date
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    product['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Category: ${product['category']}\nExpiry: ${product['expiry_date']}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
