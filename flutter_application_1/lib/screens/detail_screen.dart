import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/candi.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // detail header
          // img utamaa
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    candi.imageAsset,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // tombol back
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[100]?.withOpacity(0.8),
                      shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                ),
              ),
            ],
          ),

          // Detail Info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              // info atas
              children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      candi.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.favorite_border))
                  ],
                ),
                // info tengah
                // info bawah
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        'Lokasi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(': ${candi.location}')
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.house,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Lokasi',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(': ${candi.type}')
                  ],
                ),
                // pemisah
                SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.deepPurple.shade100,
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
