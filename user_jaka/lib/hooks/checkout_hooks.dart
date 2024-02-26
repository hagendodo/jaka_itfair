import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';

class CheckoutController {
  Future<void> checkout(String merchantId, List<dynamic> products) async {
    try {
      SignInController signInController = SignInController();
      Map<String, dynamic>? userData = await signInController.getUser();
      String token = userData?['token'];
      String userId = userData?['user']['id'];

      if (token == null) {
        throw Exception('Token not found');
      }

      if (userId == null) {
        throw Exception('User not found');
      }

      if (merchantId == null) {
        throw Exception('Merchant ID not found');
      }

      if (products == null || products.isEmpty) {
        throw Exception('Products not found or empty');
      }

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };
      print(token);

      Map<String, dynamic> payload = {
        'user_id': userId,
        'lat': -6.931,
        'lng': 107.71830,
        'merchant_id': merchantId,
        'products': products,
        'address': "Tugu Kujang FST Depan",
      };

      String body = json.encode(payload);

      http.Response response = await http.post(
        Uri.parse('${APIConstants.baseURL}/orders'),
        headers: headers,
        body: body,
      );

      print(body);

      print("kon: ${response.statusCode}");
      if (response.statusCode == 200) {
        print(json.decode(response.body)['message']);
        print(json.decode(response.body)['data']);
        print('Checkout successful!');
      } else {
        if (json.decode(response.body)['error']) {
          print(json.decode(response.body)['message']);
          print(json.decode(response.body)['data']);
          throw Exception('Maaf, Tidak Ada Penjamu Aktif Saat ini');
        }
        throw Exception('Failed to checkout');
      }
    } catch (error) {
      print('Error during checkout: $error');
      //throw Exception('Failed to checkout');
    }
  }
}
