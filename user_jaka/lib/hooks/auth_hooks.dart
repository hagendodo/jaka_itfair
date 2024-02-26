import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpController {
  Future<bool> signUp(String nim, String name, String email, String phone,
      String password) async {
    try {
      final Uri uri = Uri.parse('${APIConstants.baseURL}/auth/register');
      final Map<String, String> data = {
        'nim': nim,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'type': 'user',
      };

      final response = await http.post(uri, body: data);

      if (response.statusCode == 200) {
        final responseData = (json.decode(response.body)['data']);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('nim', nim);

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
  Future<bool> verifyOTP(String nim, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('${APIConstants.baseURL}/auth/verify-otp'),
        body: jsonEncode({'nim': nim, 'otp': otp, 'type': 'user'}),
        headers: {'Content-Type': 'application/json'},
      );

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

class SignInController {
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      final Uri uri = Uri.parse('${APIConstants.baseURL}/auth/login');
      final Map<String, String> data = {
        'email': email,
        'password': password,
        'type': 'user',
      };

      final response = await http.post(uri, body: data);

      if (response.statusCode == 200) {
        final responseData = (json.decode(response.body)['data']);
        final token = responseData['token'];
        final user = responseData['user'];
        // print('Token: $token');
        // print('User: $user');
        await saveUser({'token': token, 'user': user});

        return {'token': token, 'user': user};
      } else {
        return {};
      }
    } catch (error) {
      // print('Error: $error');
      return {};
    }
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', json.encode(userData));
  }

  Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('userData');
    if (userDataJson != null) {
      Map<String, dynamic> userData = json.decode(userDataJson);
      //print(userData['user']['id']);
      return userData;
    } else {
      return null;
    }
  }
}

class LogoutController {
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
