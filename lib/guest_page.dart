import 'package:flutter/material.dart';
import 'db_helper.dart';

class GuestPage extends StatefulWidget {
  @override
  _GuestPageState createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  List<Map<String, dynamic>> guests = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadGuests();
  }

  void loadGuests() async {
    final data = await DBHelper.getGuests();
    setState(() => guests = data);
  }

  void addGuest() async {
    if (_controller.text.isNotEmpty) {
      await DBHelper.insertGuest({
        'name': _controller.text,
        'rsvp': 0,
      });
      _controller.clear();
      loadGuests();
    }
  }

  void toggleRSVP(Map<String, dynamic> guest) async {
    await DBHelper.updateGuest(
      guest['id'],
      {
        'name': guest['name'],
        'rsvp': guest['rsvp'] == 1 ? 0 : 1,
      },
    );
    loadGuests();
  }

  void deleteGuest(int id) async {
    await DBHelper.deleteGuest(id);
    loadGuests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guest List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Enter guest name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addGuest,
                  child: Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: guests.isEmpty
                ? Center(child: Text("No guests yet"))
                : ListView.builder(
                    itemCount: guests.length,
                    itemBuilder: (ctx, i) {
                      final guest = guests[i];
                      return ListTile(
                        title: Text(guest['name']),
                        leading: IconButton(
                          icon: Icon(
                            guest['rsvp'] == 1
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: guest['rsvp'] == 1
                                ? Colors.green
                                : Colors.grey,
                          ),
                          onPressed: () => toggleRSVP(guest),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteGuest(guest['id']),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}