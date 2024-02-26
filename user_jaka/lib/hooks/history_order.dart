import 'dart:convert';
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';
import 'package:http/http.dart' as http;

class HistoryOrder {
  Future<List<dynamic>> fetchHistoryOrder() async {
    try {
      SignInController signInController = SignInController();
      Map<String, dynamic>? userData = await signInController.getUser();

      if (userData == null) {
        throw Exception('User not logged in');
      }

      String userId = userData['user']['id'];
      String? token = userData['token'];

      if (token == null) {
        throw Exception('Token not found');
      }

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('${APIConstants.baseURL}/orders?type=user&id=$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> orderData = json.decode(response.body)['data'];
        return orderData;
      } else {
        throw Exception('Failed to fetch order data');
      }
    } catch (error) {
      throw Exception('Error fetching order data: $error');
    }
  }
}
