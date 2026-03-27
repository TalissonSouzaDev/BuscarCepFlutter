import 'dart:convert';

import 'package:buscarcep/data/http/http.dart';
import 'package:http/http.dart' as http;

class HttpAdapter implements Http {
  @override
  Future<Map<String, dynamic>> get(String url) async {
    try {
      final uri = Uri.parse(url);
      return await _getRequest(uri);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> _getRequest(Uri uri) async {
    try {
      final response = await http.get(uri);
      return await _httpResponse(response);
    } catch (e) {
      throw Exception('Failed to perform GET request: $e');
    }
  }

  Future<Map<String, dynamic>> _httpResponse(http.Response response) async {
    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? Map<String, dynamic>.from(jsonDecode(response.body)) : {};
    } else {
      throw Exception('Failed to load data');
    }
  }
}