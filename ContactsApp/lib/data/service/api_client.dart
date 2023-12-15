import 'dart:convert';

import 'package:contacts_app/ui/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../source/network/model/Contact.dart';
import '../source/network/model/api_response.dart';

class ApiClient {
  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  final Map<String, String> headers = {
    "Content-Type": 'application/json',
    "Accept": 'application/json'
    // HttpHeaders.authorizationHeader:"",
  };

  Future<List<Contact>> get() async {
    String url = "${baseUrl}contacts/";
    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      final Map<String, dynamic> json = jsonDecode(response.body);
      var contacts  = List<Contact>.from(json['data'].map((data) => Contact.fromJson(data)));
      return contacts;
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> delete(int contactId) async {
    String url = "${baseUrl}contacts/$contactId";
    try {
      var response = await http.delete(Uri.parse(url), headers: headers);
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ApiResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> add(Contact contact) async {
    String url = "${baseUrl}contacts/";
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(contact.toJson()), headers: headers);
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ApiResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  Future<ApiResponse> edit(Contact contact) async {
    String url = "${baseUrl}contacts/${contact.id}";
    try {
      var response = await http.put(
        Uri.parse(url),
        body: jsonEncode(contact.toJson()),
        headers: headers,
      );
      final Map<String, dynamic> json = jsonDecode(response.body);
      return ApiResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
