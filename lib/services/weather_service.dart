import 'package:dio/dio.dart';
import 'package:hava_durumu/models/weather.dart';

class WeatherService {
  static Future<List<Hava>> weather(String sehir) async {
    try {
      Map<String, dynamic> headers = {
        "authorization": "apikey 4QNIoaEWvQ9CEhD6tqQ9o6:0DojnD4P8poRaK2DHaQIwt",
        "content-type": "application/json"
      };
      var response = await Dio().get(
          "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$sehir",
          options: Options(headers: headers));

      List<Hava> hava = [];
      if (response.statusCode == 200) {
        hava = (response.data["result"] as List)
            .map(
              (e) => Hava.fromMap(e),
            )
            .toList();
      }

      return hava;
    } catch (e) {
      return Future.error(e);
    }
  }
}
