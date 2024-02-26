import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';

class MerchantController {
  Future<List<dynamic>> fetchMerchant() async {
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
      Uri.parse('${APIConstants.baseURL}/merchants/ratings'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> merchantList = json.decode(response.body)['data'];
      return merchantList;
    } else {
      throw Exception('Failed to fetch merchants');
    }
  }

  Future<Map<String, dynamic>?> fetchMerchantByFood(String foodId) async {
    try {
      SignInController signInController = SignInController();
      Map<String, dynamic>? userData = await signInController.getUser();
      String? token = userData?['token'];
      if (token == null) {
        throw Exception('Token not found');
      }

      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(
        Uri.parse('${APIConstants.baseURL}/merchants'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> merchants = json.decode(response.body)['data'];
        if (merchants.isNotEmpty) {
          Map<String, dynamic> merchantDetails = merchants.first;
          return merchantDetails;
        } else {
          throw Exception('Merchant not found for the provided food ID');
        }
      } else {
        throw Exception('Failed to fetch merchant details');
      }
    } catch (error) {
      // print('Error fetching merchant by food: $error');
      return null;
    }
  }
}
