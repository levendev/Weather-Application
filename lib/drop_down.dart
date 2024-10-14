import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hava_durumu/hava_durumu_sayfasi.dart';
import 'package:hava_durumu/models/il_ilceler.dart';
import 'package:hava_durumu/models/texts.dart';

class DropDowns extends StatefulWidget {
  const DropDowns({super.key});

  @override
  State<DropDowns> createState() => _DropDownsState();
}

class _DropDownsState extends State<DropDowns> {
  String? sehir = null;
  String? ilce = null;
  bool goster = false;
  bool gosterButton = false;
  List<Ilceler> ilceler = [];
  late Future<List<IlIlceler>> veriler;

  @override
  void initState() {
    veriler = donder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return futureBody(veriler);
  }

  FutureBuilder<dynamic> futureBody(
    Future<List<IlIlceler>> veriler,
  ) =>
      FutureBuilder(
        future: veriler,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<IlIlceler> sehirler = snapshot.data;

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/pictures/wp.PNG'),fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Lütfen Hava Durumunu Öğrenmek İstediğiniz İl ve İlçeyi Seçiniz!",
                    style: Sabitler.homePageText,textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ilDropDownButton(sehirler),
                          _dropDownGoster(ilceler, goster),
                          _buttonGoster(gosterButton),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/pictures/wp.PNG'),fit: BoxFit.cover),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );

  DropdownButton<String> ilDropDownButton(List<IlIlceler> sehirler) {
    return DropdownButton(
      iconSize: 35,
      style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black),
      hint: Text("İl Seçiniz"),
      items: sehirler
          .map(
            (sehir) => DropdownMenuItem(
              child: Text(sehir.ilAdi),
              value: sehir.ilAdi,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          sehir = value!;
          goster = true;
          ilce = null;
          for (var element in sehirler) {
            if (element.ilAdi == value) {
              ilceler = element.ilceler;
              return;
            }
          }
        });
      },
      value: sehir,
    );
  }

  Future<List<IlIlceler>> donder() async {
    try {
      String metin = await DefaultAssetBundle.of(context)
          .loadString("assets/data/il_ilce.json");
      var jsonObject = jsonDecode(metin);

      List<IlIlceler> veri = (jsonObject as List)
          .map(
            (e) => IlIlceler.fromMap(e),
          )
          .toList();

      return veri;
    } catch (e) {
      return Future.error(e);
    }
  }

  _dropDownGoster(List<Ilceler> ilceler, bool deger) {
    return Visibility(
      visible: deger,
      child: DropdownButton(
        hint: Text("İlçe Seçiniz"),
        items: ilceler
            .map(
              (ilce) => DropdownMenuItem(
                child: Text(ilce.ilceAdi),
                value: ilce.ilceAdi,
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            ilce = value!;
            gosterButton = true;
          });
        },
        value: ilce,
      ),
    );
  }

  _buttonGoster(bool butonGoster) {
    return Visibility(
      visible: butonGoster,
      child: ElevatedButton(
          onPressed: () {
            if (ilce != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    if (ilce == "Merkez") {
                      return HavaDurumuSayfasi(sehir: sehir!);
                    } else {
                      return HavaDurumuSayfasi(sehir: ilce!);
                    }
                  },
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Center(
                      child: Text(
                "Lütfen İlçe Seçiniz!",
              ))));
            }
          },
          child: Text("Hava Durumunu Göster")),
    );
  }
}
