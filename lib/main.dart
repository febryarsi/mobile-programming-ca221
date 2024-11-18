import 'package:flutter/material.dart';
import 'package:uts_mobile_programming_220010140/pages/plant_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animal List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlantListScreen(),
    );
  }
}
