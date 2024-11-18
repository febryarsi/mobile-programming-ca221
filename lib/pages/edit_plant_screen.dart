import 'package:flutter/material.dart';
import '../models/plant.dart';

class EditPlantScreen extends StatefulWidget {
  final Plant plant;

  const EditPlantScreen({super.key, required this.plant});

  @override
  State<EditPlantScreen> createState() => _EditPlantScreenState();
}

class _EditPlantScreenState extends State<EditPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _speciesNameController;
  late TextEditingController _indonesianNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _speciesNameController =
        TextEditingController(text: widget.plant.speciesName);
    _indonesianNameController =
        TextEditingController(text: widget.plant.indonesianName);
    _descriptionController =
        TextEditingController(text: widget.plant.description);
    _imageUrlController = TextEditingController(text: widget.plant.imageUrl);
  }

  @override
  void dispose() {
    _speciesNameController.dispose();
    _indonesianNameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final updatedPlant = Plant(
        speciesName: _speciesNameController.text,
        indonesianName: _indonesianNameController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrlController.text,
      );

      Navigator.pop(context, updatedPlant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Plant'),
        backgroundColor: Colors.pink.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Species Name', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _speciesNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter species name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the species name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Indonesian Name', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _indonesianNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Indonesian name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Indonesian name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Description', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Image URL', style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: const InputDecoration(
                    hintText: 'Enter image URL',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
