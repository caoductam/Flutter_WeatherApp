import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

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

  // ✨ Cải thiện: Lấy vị trí với độ chính xác cao nhất
  Future<Position> getCurrentLocation() async {
    bool hasPermission = await requestPermission();

    if (!hasPermission) {
      throw Exception('Không có quyền truy cập vị trí');
    }

    // Cấu hình để lấy vị trí chính xác nhất
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best, // Thay đổi từ high -> best
      timeLimit: Duration(seconds: 10), // Timeout 10s
    );
  }

  // ✨ Mới: Lấy vị trí với nhiều lần thử
  Future<Position> getAccurateLocation() async {
    bool hasPermission = await requestPermission();

    if (!hasPermission) {
      throw Exception('Không có quyền truy cập vị trí');
    }

    // Lấy vị trí lần 1 (nhanh nhưng có thể không chính xác)
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Đợi 1-2 giây để GPS ổn định
    await Future.delayed(Duration(seconds: 2));

    // Lấy vị trí lần 2 (chính xác hơn)
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: Duration(seconds: 15),
    );

    return position;
  }

  // ✨ Mới: Theo dõi vị trí liên tục
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10, // Cập nhật khi di chuyển 10m
      ),
    );
  }
}
