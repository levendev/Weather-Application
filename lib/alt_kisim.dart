import 'package:flutter/material.dart';
import 'package:hava_durumu/models/texts.dart';
import 'package:hava_durumu/models/weather.dart';

class AltKisim extends StatefulWidget {
  final Function onSelect;
  final List<Hava> havaDurumlari;
  final int secilenIndex;
  const AltKisim(
      {required this.secilenIndex,
      required this.havaDurumlari,
      required this.onSelect,
      super.key});

  @override
  State<AltKisim> createState() => _nameState();
}

class _nameState extends State<AltKisim> {
  @override
  Widget build(BuildContext context) {
    List<Hava> havaDurumlari = widget.havaDurumlari;
    return Container(
      width: double.infinity - 100,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(0);
            },
            child: gunleriOlustur(havaDurumlari[0], 0),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(1);
            },
            child: gunleriOlustur(havaDurumlari[1], 1),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(2);
            },
            child: gunleriOlustur(havaDurumlari[2], 2),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(3);
            },
            child: gunleriOlustur(havaDurumlari[3], 3),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(4);
            },
            child: gunleriOlustur(havaDurumlari[4], 4),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(5);
            },
            child: gunleriOlustur(havaDurumlari[5], 5),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              widget.onSelect(6);
            },
            child: gunleriOlustur(havaDurumlari[6], 6),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Material gunleriOlustur(Hava havaDurumu, int secilen) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      color: secilen == widget.secilenIndex ? Colors.grey.withOpacity(0.6) : null,
      child: Container(
        width: 100,
        height: 100,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Center(
                child: Text(
                  "${dereceler(havaDurumu.degree)}°C",
                  style: Sabitler.alt,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(havaDurumu.icon),
                  fit: BoxFit.contain,
                ),
              ),
              width: double.infinity,
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 20,
              child: Center(
                  child: Text(
                havaDurumu.day,
                style: Sabitler.alt,
              )),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  String dereceler(String x) {
    String metin = x.split(".")[0];
    return metin;
  }
}
