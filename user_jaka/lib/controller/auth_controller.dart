import 'package:dio/dio.dart';

class SignUpController {
  final String baseUrl = 'https://jaka-green.vercel.app/api/v1/auth/register';

  Future<bool> signUp(String nim, String name, String email, String phone,
      String password) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

      Map<String, dynamic> data = {
        'nim': nim,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'type': 'user',
      };

      Response response = await dio.post('/', data: data);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

class OTPController {
  final String baseUrl = 'https://jaka-green.vercel.app/api/v1/auth/verify-otp';

  Future<bool> verifyOTP(String nim, String otp) async {
    try {
      Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

      Response response = await dio.post(baseUrl, data: {
        'nim': nim,
        'otp': otp,
        'type': 'user',
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
