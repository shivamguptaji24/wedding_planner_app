import 'package:flutter/material.dart';

class VenueDetailPage extends StatelessWidget {
  final Map<String, dynamic> venue;

  VenueDetailPage({required this.venue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(venue['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "venue_${venue['id']}",
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.pink.shade100,
                ),
                child: Icon(Icons.location_city, size: 100, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text("Location: ${venue['location']}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Capacity: ${venue['capacity']} guests", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Price Range: ₹${venue['price_min']} - ₹${venue['price_max']}",
                style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}