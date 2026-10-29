
import 'package:flutter/material.dart';

void main() {
  runApp(const LostAndFoundApp());
}

// ---------------- Data Model ----------------
class LostFoundItem {
  final String name;
  final String location;
  final String status; // "Lost" or "Found"
  final String description;
  final String date;
  final String contact;

  const LostFoundItem({
    required this.name,
    required this.location,
    required this.status,
    required this.description,
    required this.date,
    required this.contact,
  });
}

// ---------------- Sample Data (8 items) ----------------
const List<LostFoundItem> items = [
  LostFoundItem(
    name: 'Black Backpack',
    location: 'Library',
    status: 'Lost',
    description: 'Black backpack with a laptop and two notebooks inside.',
    date: '25 Oct 2026',
    contact: '0300-1111111',
  ),
  LostFoundItem(
    name: 'Student ID Card',
    location: 'Cafeteria',
    status: 'Found',
    description: 'Air University student ID card found near the counter.',
    date: '26 Oct 2026',
    contact: 'Security Office',
  ),
  LostFoundItem(
    name: 'Casio Calculator',
    location: 'Exam Hall 2',
    status: 'Lost',
    description: 'Silver scientific calculator with a name sticker.',
    date: '24 Oct 2026',
    contact: '0311-2222222',
  ),
  LostFoundItem(
    name: 'Car Keys',
    location: 'Parking Area',
    status: 'Found',
    description: 'Toyota car keys with a red keychain.',
    date: '27 Oct 2026',
    contact: 'Security Office',
  ),
  LostFoundItem(
    name: 'Water Bottle',
    location: 'CS Department',
    status: 'Lost',
    description: 'Blue steel water bottle with a small dent.',
    date: '23 Oct 2026',
    contact: '0322-3333333',
  ),
  LostFoundItem(
    name: 'Wireless Earbuds',
    location: 'Computer Lab 1',
    status: 'Found',
    description: 'White earbuds in a charging case.',
    date: '28 Oct 2026',
    contact: 'Lab Incharge',
  ),
  LostFoundItem(
    name: 'Prescription Glasses',
    location: 'Mosque',
    status: 'Lost',
    description: 'Black frame glasses inside a brown case.',
    date: '22 Oct 2026',
    contact: '0333-4444444',
  ),
  LostFoundItem(
    name: 'Umbrella',
    location: 'Main Gate',
    status: 'Found',
    description: 'Large black umbrella left near the guard room.',
    date: '29 Oct 2026',
    contact: 'Main Gate Guard',
  ),
];

// ---------------- App ----------------
class LostAndFoundApp extends StatelessWidget {
  const LostAndFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Lost & Found',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ItemListScreen(),
    );
  }
}

// ---------------- Screen 1: Item List ----------------
class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Lost & Found'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final bool isLost = item.status == 'Lost';

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isLost ? Colors.red : Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18),
                      const SizedBox(width: 4),
                      Text(item.location),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ItemDetailsScreen(item: item),
                          ),
                        );
                      },
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- Screen 2: Item Details ----------------
class ItemDetailsScreen extends StatelessWidget {
  final LostFoundItem item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final bool isLost = item.status == 'Lost';

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    isLost ? Icons.search : Icons.check_circle,
                    size: 80,
                    color: isLost ? Colors.red : Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                _detailRow('Name', item.name),
                _detailRow('Location', item.location),
                _detailRow('Status', item.status),
                _detailRow('Date', item.date),
                _detailRow('Contact', item.contact),
                _detailRow('Description', item.description),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
 