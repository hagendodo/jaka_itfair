import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';

class FoodHooksController {
  Future<List<dynamic>> fetchProduct() async {
    SignInController signInController = SignInController();
    Map<String, dynamic>? userData = await signInController.getUser();
    String? token = userData?['token'];
    if (token == null) {
      throw Exception('Token not found');
    }

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse('${APIConstants.baseURL}/products'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> merchantList = json.decode(response.body)['data'];
      return merchantList;
    } else {
      throw Exception('Failed to fetch merchants');
    }
  }
}
