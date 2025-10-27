import 'package:geolocator/geolocator.dart';

class LocationService {
  // Kiểm tra và yêu cầu quyền truy cập vị trí
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kiểm tra GPS có bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Kiểm tra quyền
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  // Lấy vị trí hiện tại
  Future<Position> getCurrentLocation() async {
    bool hasPermission = await requestPermission();

    if (!hasPermission) {
      throw Exception('Không có quyền truy cập vị trí');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
