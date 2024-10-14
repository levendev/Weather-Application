import 'package:flutter/material.dart';
import 'package:hava_durumu/drop_down.dart';
import 'package:hava_durumu/hava_durumu_sayfasi.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hava Durumu"),
        backgroundColor: Colors.teal.withOpacity(0.8),
      ),
      body: DropDowns(),
    );
  }
}
