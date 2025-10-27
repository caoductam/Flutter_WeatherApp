// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import '../models/weather_model.dart';
// import '../services/location_service.dart';
// import '../services/weather_service.dart';

// class WeatherScreen extends StatefulWidget {
//   const WeatherScreen({Key? key}) : super(key: key);

//   @override
//   State<WeatherScreen> createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   final LocationService _locationService = LocationService();
//   final WeatherService _weatherService = WeatherService();

//   Future<Weather>? _weatherFuture;

//   @override
//   void initState() {
//     super.initState();
//     _loadWeather();
//   }

//   // Load dữ liệu thời tiết
//   void _loadWeather() {
//     setState(() {
//       _weatherFuture = _fetchWeather();
//     });
//   }

//   Future<Weather> _fetchWeather() async {
//     try {
//       // Lấy vị trí hiện tại
//       Position position = await _locationService.getCurrentLocation();

//       // Lấy dữ liệu thời tiết
//       Weather weather = await _weatherService.getWeatherByCoordinates(
//         position.latitude,
//         position.longitude,
//       );

//       return weather;
//     } catch (e) {
//       throw Exception('Lỗi: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade400,
//       appBar: AppBar(
//         title: const Text('Weather App'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           IconButton(icon: const Icon(Icons.refresh), onPressed: _loadWeather),
//         ],
//       ),
//       body: FutureBuilder<Weather>(
//         future: _weatherFuture,
//         builder: (context, snapshot) {
//           // Đang tải
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             );
//           }

//           // Có lỗi
//           if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     size: 60,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Lỗi: ${snapshot.error}',
//                     style: const TextStyle(color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _loadWeather,
//                     child: const Text('Thử lại'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Có dữ liệu
//           if (snapshot.hasData) {
//             Weather weather = snapshot.data!;
//             return _buildWeatherDisplay(weather);
//           }

//           return const Center(child: Text('Không có dữ liệu'));
//         },
//       ),
//     );
//   }

//   Widget _buildWeatherDisplay(Weather weather) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Tên thành phố
//             Text(
//               weather.cityName,
//               style: const TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 8),

//             // Mô tả thời tiết
//             Text(
//               weather.description.toUpperCase(),
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white70,
//                 letterSpacing: 1.5,
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Icon thời tiết
//             Image.network(
//               _weatherService.getIconUrl(weather.icon),
//               width: 150,
//               height: 150,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(Icons.cloud, size: 150, color: Colors.white);
//               },
//             ),
//             const SizedBox(height: 16),

//             // Nhiệt độ
//             Text(
//               '${weather.temperature.round()}°C',
//               style: const TextStyle(
//                 fontSize: 72,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Thông tin chi tiết
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 children: [
//                   _buildDetailRow(
//                     Icons.thermostat,
//                     'Cảm giác như',
//                     '${weather.feelsLike.round()}°C',
//                   ),
//                   const Divider(color: Colors.white30),
//                   _buildDetailRow(
//                     Icons.water_drop,
//                     'Độ ẩm',
//                     '${weather.humidity}%',
//                   ),
//                   const Divider(color: Colors.white30),
//                   _buildDetailRow(
//                     Icons.air,
//                     'Tốc độ gió',
//                     '${weather.windSpeed.toStringAsFixed(1)} m/s',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: Colors.white, size: 24),
//               const SizedBox(width: 12),
//               Text(
//                 label,
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  Future<Weather>? _weatherFuture;
  Position? _currentPosition; // Lưu vị trí hiện tại

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() {
    setState(() {
      _weatherFuture = _fetchWeather();
    });
  }

  // ✨ Cải thiện: Sử dụng phương thức lấy vị trí chính xác hơn
  Future<Weather> _fetchWeather() async {
    try {
      // Hiển thị thông báo đang lấy vị trí
      print('📍 Đang lấy vị trí GPS...');

      // Lấy vị trí với độ chính xác cao
      Position position = await _locationService.getAccurateLocation();
      _currentPosition = position;

      print('✅ Vị trí: ${position.latitude}, ${position.longitude}');
      print('🎯 Độ chính xác: ${position.accuracy}m');

      // Lấy dữ liệu thời tiết
      Weather weather = await _weatherService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      return weather;
    } catch (e) {
      print('❌ Lỗi: $e');
      throw Exception('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        title: const Text('Weather App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWeather,
            tooltip: 'Làm mới',
          ),
          // ✨ Mới: Nút xem vị trí
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _showLocationInfo,
            tooltip: 'Thông tin vị trí',
          ),
        ],
      ),
      body: FutureBuilder<Weather>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Đang lấy vị trí GPS chính xác...',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Lỗi: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadWeather,
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            Weather weather = snapshot.data!;
            return _buildWeatherDisplay(weather);
          }

          return const Center(child: Text('Không có dữ liệu'));
        },
      ),
    );
  }

  // ✨ Mới: Hiển thị thông tin vị trí
  void _showLocationInfo() {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Chưa có thông tin vị trí')));
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thông tin vị trí'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vĩ độ: ${_currentPosition!.latitude.toStringAsFixed(6)}'),
            Text('Kinh độ: ${_currentPosition!.longitude.toStringAsFixed(6)}'),
            const SizedBox(height: 8),
            Text(
              'Độ chính xác: ${_currentPosition!.accuracy.toStringAsFixed(1)}m',
              style: TextStyle(
                color: _currentPosition!.accuracy < 50
                    ? Colors.green
                    : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _currentPosition!.accuracy < 50
                  ? '✅ Vị trí chính xác'
                  : '⚠️ Độ chính xác thấp, thử ở ngoài trời',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDisplay(Weather weather) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✨ Hiển thị độ chính xác vị trí
            if (_currentPosition != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: _currentPosition!.accuracy < 50
                          ? Colors.greenAccent
                          : Colors.orangeAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Độ chính xác: ${_currentPosition!.accuracy.toStringAsFixed(0)}m',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),

            Text(
              weather.cityName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              weather.description.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            Image.network(
              _weatherService.getIconUrl(weather.icon),
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.cloud, size: 150, color: Colors.white);
              },
            ),
            const SizedBox(height: 16),

            Text(
              '${weather.temperature.round()}°C',
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    Icons.thermostat,
                    'Cảm giác như',
                    '${weather.feelsLike.round()}°C',
                  ),
                  const Divider(color: Colors.white30),
                  _buildDetailRow(
                    Icons.water_drop,
                    'Độ ẩm',
                    '${weather.humidity}%',
                  ),
                  const Divider(color: Colors.white30),
                  _buildDetailRow(
                    Icons.air,
                    'Tốc độ gió',
                    '${weather.windSpeed.toStringAsFixed(1)} m/s',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
