import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_id_flutter/model/quotes_model.dart';

class QuotesApi {
  static const String BASE_URL = 'fcapi-1y70.onrender.com';

  Future<List<Quotes>> getQuotes() async {
    final uri = Uri.https(BASE_URL, '/quotes');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonString = response.body;
        final List<Quotes> quotes = await compute(_parseQuotes, jsonString);
        return quotes;
      } else {
        throw ApiException('Failed to load quotes. Status code: ${response.statusCode}');
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('An error occurred: $e');
    }
  }
}

List<Quotes> _parseQuotes(String jsonString) {
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((json) => Quotes.fromJson(json)).toList();
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
