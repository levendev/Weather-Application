import 'package:flutter/material.dart';
import 'package:hava_durumu/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      title: 'Hava Durumu',
      home: HomePage(),
    );
  }
}

