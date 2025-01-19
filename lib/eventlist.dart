import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('events');
  List<Map<String, String>> events = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  void _fetchEvents() {
    _dbRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        setState(() {
          events = data.entries.map((e) {
            return {
              'id': e.key,
              'title': e.value['title']?.toString() ?? '',
              'description': e.value['description']?.toString() ?? ''
            };
          }).toList();
        });
      } else {
        setState(() {
          events = [];
        });
      }
    });
  }

  void _addEvent() async {
    final newEvent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventFormPage()),
    );
    if (newEvent != null) {
      _dbRef.push().set(newEvent);
    }
  }

  void _editEvent(int index) async {
    final updatedEvent = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventFormPage(event: events[index]),
      ),
    );
    if (updatedEvent != null) {
      _dbRef.child(events[index]['id']!).update(updatedEvent);
    }
  }

  void _deleteEvent(String id) {
    _dbRef.child(id).remove();
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = events
        .where((event) =>
        event['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search events...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
        ),
        backgroundColor: Colors.teal.shade900,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: filteredEvents.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text(filteredEvents[index]['title']!),
                subtitle: Text(filteredEvents[index]['description']!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.teal.shade700),
                      onPressed: () => _editEvent(index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteEvent(filteredEvents[index]['id']!),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QRDisplayPage(filteredEvents[index]['title']!),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class EventFormPage extends StatelessWidget {
  final Map<String, String>? event;

  EventFormPage({this.event});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (event != null) {
      _titleController.text = event!['title']!;
      _descriptionController.text = event!['description']!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(event == null ? 'Add Event' : 'Edit Event'),
        backgroundColor: Colors.teal.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    {'title': _titleController.text, 'description': _descriptionController.text},
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

class QRDisplayPage extends StatelessWidget {
  final String title;

  QRDisplayPage(this.title);

  @override
  Widget build(BuildContext context) {
    final qrUrl =
        'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${Uri.encodeComponent(title)}';

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor: Colors.teal.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              qrUrl,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'Failed to load QR Code. Please try again.',
                  style: TextStyle(color: Colors.red),
                );
              },
            ),
            SizedBox(height: 20),
            Text('QR Code for: $title'),
          ],
        ),
      ),
    );
  }
}
