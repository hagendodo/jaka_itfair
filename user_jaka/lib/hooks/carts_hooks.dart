import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_jaka/hooks/api_hooks.dart';
import 'package:user_jaka/hooks/auth_hooks.dart';

class CartController {
  Future<List<dynamic>> fetchProductsForCart() async {
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
      List<dynamic> productList = json.decode(response.body)['data'];
      return productList;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  Future<dynamic> addToCart(String productId, String merchantId) async {
    SignInController signInController = SignInController();
    Map<String, dynamic>? userData = await signInController.getUser();

    String token = userData?['token'];
    String userId = userData?['user']['id'];

    if (token == "" || userId == "") {
      throw Exception('Token or user ID not found');
    }

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> requestData = {
      'user_id': userId,
      'product_id': productId,
      'merchant_id': merchantId,
    };

    final response = await http.post(
      Uri.parse('${APIConstants.baseURL}/carts'),
      headers: headers,
      body: json.encode(requestData),
    );

    if (response.statusCode == 201) {
      dynamic cartlist = json.decode(response.body)['message'];
      return cartlist;
    } else {
      throw Exception('Failed to add product to cart: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchCartUser() async {
    try {
      SignInController signInController = SignInController();
      Map<String, dynamic>? userData = await signInController.getUser();
      String userId = userData?['user']['id'];

      if (userData == null) {
        throw Exception('User not logged in');
      }

      String? token = userData['token'];

      if (token == null) {
        throw Exception('Token not found');
      }

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      // print(userId);
      // print(token);
      final response = await http.get(
        Uri.parse('${APIConstants.baseURL}/carts?user_id=$userId'),
        headers: headers,
      );

      // print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> cartData = json.decode(response.body)['data'];
        // print(cartData);
        return cartData;
      } else {
        throw Exception('Failed to fetch cart data');
      }
    } catch (error) {
      throw Exception('Error fetching cart data: $error');
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      SignInController signInController = SignInController();
      Map<String, dynamic>? userData = await signInController.getUser();
      String token = userData?['token'];

      if (token == null) {
        throw Exception('Token not found');
      }

      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.delete(
        Uri.parse('${APIConstants.baseURL}/carts/$cartItemId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete cart item');
      }
    } catch (error) {
      throw Exception('Error deleting cart item: $error');
    }
  }

  Future<List<dynamic>> fetchCartByMerchant(String merchantId) async {
    try {
      SignInController signInController = SignInController();
      Map<String, dynamic>? userData = await signInController.getUser();

      if (userData == null) {
        throw Exception('User not logged in');
      }

      String? token = userData['token'];

      if (token == null) {
        throw Exception('Token not found');
      }

      String userId = userData['user']['id'];
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse(
            '${APIConstants.baseURL}/carts/merchant/$merchantId?user_id=$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> cartData = json.decode(response.body)['data'];
        return cartData;
      } else {
        throw Exception('Failed to fetch cart data');
      }
    } catch (error) {
      throw Exception('Error fetching cart data: $error');
    }
  }
}
