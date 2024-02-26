import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';

class MerchantFoodController {
  Future<List<dynamic>> fetchFoodMerchant(String merchantId) async {
    if (merchantId == null) {
      throw Exception('Merchant ID not found');
    }

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
      Uri.parse('${APIConstants.baseURL}/products?merchant_id=$merchantId'),
      headers: headers,
    );

    // Memeriksa apakah respons berhasil
    if (response.statusCode == 200) {
      List<dynamic> foodlist = json.decode(response.body)['data'];
      return foodlist;
    } else {
      throw Exception('Failed to fetch merchants');
    }
  }
}
