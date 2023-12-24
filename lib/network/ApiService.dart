/*
import 'package:dio/dio.dart';

import '../model/Contact.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Contact>> fetchContacts() async {
    try {
      final response = await _dio.get('https://cognizant.free.beeceptor.com/contacts');
      final result = response.data as Contact;
      return jsonList.map((json) => Contact.fromJson(json)).toList();
    } catch (error) {
      throw Exception('Failed to fetch contacts');
    }
  }
}*/
