import 'dart:convert';

IlIlceler ilIlcelerFromMap(String str) => IlIlceler.fromMap(json.decode(str));

String ilIlcelerToMap(IlIlceler data) => json.encode(data.toMap());

class IlIlceler {
  final String ilAdi;
  final String plakaKodu;
  final List<Ilceler> ilceler;
  final String kisaBilgi;

  IlIlceler({
    required this.ilAdi,
    required this.plakaKodu,
    required this.ilceler,
    required this.kisaBilgi,
  });

  factory IlIlceler.fromMap(Map<String, dynamic> json) => IlIlceler(
        ilAdi: json["il_adi"],
        plakaKodu: json["plaka_kodu"],
        ilceler:
            List<Ilceler>.from(json["ilceler"].map((x) => Ilceler.fromMap(x))),
        kisaBilgi: json["kisa_bilgi"],
      );

  Map<String, dynamic> toMap() => {
        "il_adi": ilAdi,
        "plaka_kodu": plakaKodu,
        "ilceler": List<dynamic>.from(ilceler.map((x) => x.toMap())),
        "kisa_bilgi": kisaBilgi,
      };
}

class Ilceler {
  final String ilceAdi;
  final String nufus;
  final String erkekNufus;
  final String kadinNufus;
  final String yuzolcumu;

  Ilceler({
    required this.ilceAdi,
    required this.nufus,
    required this.erkekNufus,
    required this.kadinNufus,
    required this.yuzolcumu,
  });

  factory Ilceler.fromMap(Map<String, dynamic> json) => Ilceler(
        ilceAdi: json["ilce_adi"],
        nufus: json["nufus"],
        erkekNufus: json["erkek_nufus"],
        kadinNufus: json["kadin_nufus"],
        yuzolcumu: json["yuzolcumu"],
      );

  Map<String, dynamic> toMap() => {
        "ilce_adi": ilceAdi,
        "nufus": nufus,
        "erkek_nufus": erkekNufus,
        "kadin_nufus": kadinNufus,
        "yuzolcumu": yuzolcumu,
      };
}
