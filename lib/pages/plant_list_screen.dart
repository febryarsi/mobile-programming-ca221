import 'package:flutter/material.dart';
import 'package:uts_mobile_programming_220010140/pages/add_plant_screen.dart';
import 'package:uts_mobile_programming_220010140/pages/edit_plant_screen.dart';
import '../models/plant.dart';

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({super.key});

  @override
  _PlantListScreenState createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  // Daftar awal tumbuhan
  final List<Plant> _plants = [
    Plant(
      speciesName: 'Monstera deliciosa',
      indonesianName: 'Janda Bolong',
      description: 'Tumbuhan hias dengan daun besar dan bolong-bolong.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIYzSvHtlFl50z0IFK7390mWaePGzpEZsp_A&s',
    ),
    Plant(
      speciesName: 'Nepenthes ampullaria',
      indonesianName: 'Kantong Semar',
      description: 'Tumbuhan karnivora dengan kantong untuk menjebak serangga.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7DQi5pr_7ltNTIk--V1tHY_9kqQplmn_qqg&s',
    ),
  ];

  void _addPlant(Plant plant) {
    setState(() {
      _plants.add(plant);
    });
  }

  void _editPlant(int index, Plant updatedPlant) {
    setState(() {
      _plants[index] = updatedPlant;
    });
  }

  void _deletePlant(int index) {
    setState(() {
      _plants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant List'),
        backgroundColor: Colors.pink.shade400,
      ),
      body: _plants.isEmpty
          ? const Center(child: Text('No plants added yet.'))
          : ListView.builder(
              itemCount: _plants.length,
              itemBuilder: (context, index) {
                return PlantItem(
                  plant: _plants[index],
                  onEdit: () async {
                    final updatedPlant = await Navigator.push<Plant>(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditPlantScreen(plant: _plants[index]),
                      ),
                    );
                    if (updatedPlant != null) {
                      _editPlant(index, updatedPlant);
                    }
                  },
                  onDelete: () => _deletePlant(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newPlant = await Navigator.push<Plant>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPlantScreen(),
            ),
          );
          if (newPlant != null) {
            _addPlant(newPlant);
          }
        },
        backgroundColor: Colors.pink.shade400,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PlantItem extends StatelessWidget {
  final Plant plant;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PlantItem({
    super.key,
    required this.plant,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              plant.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plant.indonesianName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  plant.speciesName,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  plant.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: onEdit,
                      child: const Text('Edit'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: onDelete,
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
