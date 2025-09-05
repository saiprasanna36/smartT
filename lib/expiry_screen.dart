import 'package:flutter/material.dart';

class ExpiryScreen extends StatelessWidget {
  final String productName;

  ExpiryScreen({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expiry Details'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Product: $productName",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),

            // Expiry Date Placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expiry Date:", style: TextStyle(fontSize: 18)),
                Text("DD/MM/YYYY", // Replace with actual expiry date logic
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
            Divider(thickness: 1, height: 30),

            // Actions
            Column(
              children: [
                // Mark as Used Button
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Mark as Used Logic
                    print("$productName marked as used");
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.check_circle, color: Colors.white),
                  label: Text("Mark as Used"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 15),

                // Snooze Button
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Snooze Logic
                    print("Snoozing notification for $productName");
                  },
                  icon: Icon(Icons.snooze, color: Colors.white),
                  label: Text("Snooze Reminder"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                SizedBox(height: 15),

                // Delete Item Button
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement Delete Logic
                    print("Deleting $productName from the list");
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text("Delete Item"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
