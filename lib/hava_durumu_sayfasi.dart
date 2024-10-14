import 'package:flutter/material.dart';
import 'package:hava_durumu/models/texts.dart';
import 'package:hava_durumu/models/weather.dart';
import 'package:hava_durumu/my_body.dart';
import 'package:hava_durumu/services/weather_service.dart';

class HavaDurumuSayfasi extends StatefulWidget {
  final String sehir;
  const HavaDurumuSayfasi({required this.sehir, super.key});

  @override
  State<HavaDurumuSayfasi> createState() => _HavaDurumuSayfasiState();
}

class _HavaDurumuSayfasiState extends State<HavaDurumuSayfasi> {
  late Future<List<Hava>> havaDurumu;
  late String sehir;
  int secilenGun = 1;

  @override
  void initState() {
    super.initState();
    sehir = widget.sehir;
    havaDurumu = WeatherService.weather(sehir);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$sehir 7 Günlük Hava Durumu",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.teal,
      ),
      body: myBody(),
    );
  }

  FutureBuilder<List<Hava>> myBody() {
    return FutureBuilder(
      future: havaDurumu,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          List<Hava> havaDurumlari = snapshot.data!;

          return MyBody(
            havaDurumlari: havaDurumlari,
            secilenGun: secilenGun,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
