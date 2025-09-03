import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'venue_detail_page.dart';

class VenuesPage extends StatefulWidget {
  @override
  _VenuesPageState createState() => _VenuesPageState();
}

class _VenuesPageState extends State<VenuesPage> {
  List<dynamic> venues = [];
  List<dynamic> filteredVenues = [];

  double _maxBudget = 200000; // default filter
  int _minCapacity = 100;

  @override
  void initState() {
    super.initState();
    loadVenues();
  }

  Future<void> loadVenues() async {
    final String response = await rootBundle.loadString('assets/venues.json');
    final data = json.decode(response);
    setState(() {
      venues = data;
      filteredVenues = venues; // initially show all
    });
  }

  void applyFilter() {
    setState(() {
      filteredVenues = venues.where((venue) {
        final budgetOk = venue['price_max'] <= _maxBudget;
        final capacityOk = venue['capacity'] >= _minCapacity;
        return budgetOk && capacityOk;
      }).toList();
    });
    Navigator.pop(context); // close bottom sheet
  }

  void openFilter() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Filter Venues",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20),
                  Text("Max Budget: ₹${_maxBudget.toInt()}"),
                  Slider(
                    value: _maxBudget,
                    min: 50000,
                    max: 300000,
                    divisions: 10,
                    onChanged: (val) {
                      setModalState(() => _maxBudget = val);
                    },
                  ),

                  SizedBox(height: 20),
                  Text("Min Capacity: $_minCapacity"),
                  Slider(
                    value: _minCapacity.toDouble(),
                    min: 50,
                    max: 500,
                    divisions: 9,
                    onChanged: (val) {
                      setModalState(() => _minCapacity = val.toInt());
                    },
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: applyFilter,
                    child: Text("Apply Filter"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wedding Venues'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: openFilter,
          )
        ],
      ),
      body: filteredVenues.isEmpty
          ? Center(child: Text('No venues match your filter'))
          : ListView.builder(
              itemCount: filteredVenues.length,
              itemBuilder: (context, index) {
                final venue = filteredVenues[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VenueDetailPage(venue: venue),
                      ),
                    );
                  },
                  child: Hero(
                    tag: "venue_${venue['id']}",
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(venue['name']),
                        subtitle: Text(
                          "${venue['location']} • Capacity: ${venue['capacity']}",
                        ),
                        trailing: Text(
                          "₹${venue['price_min']} - ₹${venue['price_max']}",
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}