import 'package:dio/dio.dart';

class DeviceTokenService {
  final Dio _dio = Dio();

  Future<bool> saveDeviceToken({
    required String token,
    required String deviceType, // 'android' or 'ios'
    required String authToken,   // ← add thi
  }) async {
    try {
      final response = await _dio.post(
        'https://wheaton.co.in/api/save-device-token',
        data: {
          'token': token,
          'device_type': deviceType,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add auth header if needed:
            'Authorization': 'Bearer $authToken',  // ← add this
         },
        ),
      );

      if (response.statusCode == 200 && response.data['status'] == true) {
        print('Token saved: ${response.data['message']}');
        return true;
      }

      return false;
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }
}