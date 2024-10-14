import 'package:flutter/material.dart';
import 'package:hava_durumu/alt_kisim.dart';
import 'package:hava_durumu/models/texts.dart';
import 'package:hava_durumu/models/weather.dart';

class MyBody extends StatefulWidget {
  final List<Hava> havaDurumlari;
  final int secilenGun;
  const MyBody(
      {required this.havaDurumlari, required this.secilenGun, super.key});

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  String _arkaPlan = "assets/pictures/arka_plan.PNG";
  int secilenGun = 0;

  @override
  void initState() {
    secilenGun = widget.secilenGun;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Hava> havaDurumlari = widget.havaDurumlari;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(_arkaPlan), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30, left: 30, right: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2 + 50,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    havaDurumlari[secilenGun].date,
                    style: Sabitler.stil,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  havaDurumlari[secilenGun].day,
                  style: Sabitler.gun,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.network(
                    havaDurumlari[secilenGun].icon,
                    height: 75,
                    width: 75,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hava Sıcaklığı: ",
                        style: Sabitler.stil,
                      ),
                      Text(
                        "${dereceler(havaDurumlari[secilenGun].degree)}°C",
                        style: Sabitler.derece,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Min Sıcaklık: ",
                      style: Sabitler.sicaklik,
                    ),
                    Text(
                      "${dereceler(havaDurumlari[secilenGun].min)}°C",
                      style: Sabitler.sicaklikMin,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Max Sıcaklık: ",
                      style: Sabitler.sicaklik,
                    ),
                    Text(
                      "${dereceler(havaDurumlari[secilenGun].max)}°C",
                      style: Sabitler.sicaklikMax,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nem Oranı: ",
                      style: Sabitler.sicaklik,
                    ),
                    Text("${havaDurumlari[secilenGun].humidity}%",
                        style: Sabitler.nem),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Hava Durumu: ",
                      style: Sabitler.sicaklik,
                    ),
                    Text(
                      "${havaAcikligi(havaDurumlari[secilenGun].description)}",
                      style: Sabitler.durum,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Gece Sıcaklık: ",
                      style: Sabitler.sicaklik,
                    ),
                    Text(
                      "${dereceler(havaDurumlari[secilenGun].night)}°C",
                      style: Sabitler.gece,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          AltKisim(
              secilenIndex: secilenGun,
              havaDurumlari: havaDurumlari,
              onSelect: (e) {
                setState(() {
                  secilenGun = e;
                });
              }),
        ],
      ),
    );
  }

  String dereceler(String x) {
    String metin = x.split(".")[0];
    return metin;
  }

  String havaAcikligi(String x) {
    switch (x) {
      case "açık":
        return "Açık";

      case "parçalı bulutlu":
        return "Parçalı\nBulutlu";

      case "hafif yağmur":
        return "Hafif\nYağmurlu";

      case "kapalı":
        return "Kapalı";

      case "parçalı az bulutlu":
        return "Az\nBulutlu";

      case "az bulutlu":
        return "Az\nBulutlu";

      case "orta şiddetli yağmur":
        return 'Orta\nŞiddetli\nYağmur';

      default:
        return x;
    }
  }
}
