import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey =
      'e760d40b60fc82b10ac9aceb9a34c10a'; // Thay bằng API key của bạn
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // Lấy thời tiết theo tọa độ
  Future<Weather> getWeatherByCoordinates(double lat, double lon) async {
    final url = Uri.parse(
      '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric&lang=vi',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Không thể tải dữ liệu thời tiết');
    }
  }

  // Lấy URL icon thời tiết
  String getIconUrl(String iconCode) {
    return 'https://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  // Lấy thời tiết theo tên thành phố
  Future<Weather> getWeatherByCity(String cityName) async {
    final url = Uri.parse(
      '$baseUrl?q=$cityName&appid=$apiKey&units=metric&lang=vi',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Không tìm thấy thành phố');
    }
  }
}
