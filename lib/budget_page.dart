import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final _controller = TextEditingController();
  double? totalBudget;

  Map<String, double> breakdown = {};

  void calculate() {
    final input = double.tryParse(_controller.text);
    if (input != null) {
      setState(() {
        totalBudget = input;
        breakdown = {
          "Venue": input * 0.4,
          "Catering": input * 0.3,
          "Decor": input * 0.2,
          "Misc": input * 0.1,
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Budget Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Total Budget (₹)", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g. 200000",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: Text("Calculate"),
            ),
            SizedBox(height: 30),
            if (breakdown.isNotEmpty) ...[
              Text("Breakdown:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ...breakdown.entries.map(
                (e) => ListTile(
                  title: Text(e.key),
                  trailing: Text("₹${e.value.toInt()}"),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}