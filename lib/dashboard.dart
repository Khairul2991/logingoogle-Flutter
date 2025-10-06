import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Contoh data yang nanti bisa diganti dengan data dinamis lain
  List<Map<String, dynamic>> waterMeterData = [
    {
      'villageName': 'Village 1',
      'id': 'WM-001',
      'address': 'Jl. Mawar No. 5',
      'totalToday': 2.5,
    },
    {
      'villageName': 'Village 2',
      'id': 'WM-002',
      'address': 'Jl. Melati No. 7',
      'totalToday': 1.8,
    },
    {
      'villageName': 'Village 3',
      'id': 'WM-003',
      'address': 'Jl. Kenanga No. 9',
      'totalToday': 3.2,
    },
  ];

  void _addWaterMeter() {
    setState(() {
      int newIndex = waterMeterData.length + 1;
      waterMeterData.add({
        'villageName': 'Village $newIndex',
        'id': 'WM-00$newIndex',
        'address': 'Jl. Baru No. $newIndex',
        'totalToday': 1.0 + newIndex * 0.5,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await GoogleSignIn().disconnect();
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Menampilkan list data secara dinamis
        child: ListView.builder(
          itemCount: waterMeterData.length,
          itemBuilder: (context, index) {
            final meter = waterMeterData[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meter['villageName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text("ID: ${meter['id']}"),
                    Text("Address: ${meter['address']}"),
                    Text("Total Today: ${meter['totalToday']} m³"),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () async {

                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Details',
                              style: TextStyle(
                                color: Color(0xFF595959),
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Color(0xFF595959),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWaterMeter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
