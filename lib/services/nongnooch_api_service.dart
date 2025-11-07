import 'dart:convert';
import 'package:dio/dio.dart';

/// Lightweight API service for selected Nongnooch endpoints
/// Temporary solution until the full OpenAPI client is generated.
class NongnoochApiService {
  NongnoochApiService({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: 'https://sales-backend.nongnooch.app',
          headers: const {'accept': 'application/json'},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
        ));

  final Dio _dio;

  /// GET /api/quotation-details/types
  /// Returns a list of quotation types with Thai/English names.
  Future<List<QuotationType>> getQuotationDetailTypes() async {
    try {
      final resp = await _dio.get('/api/quotation-details/types');
      final data = resp.data;
      if (data is List) {
        return data
            .whereType<Map<String, dynamic>>()
            .map(QuotationType.fromJson)
            .toList();
      }
      // Handle cases where Dio returns raw string
      if (data is String) {
        final decoded = jsonDecode(data);
        if (decoded is List) {
          return decoded
              .whereType<Map<String, dynamic>>()
              .map(QuotationType.fromJson)
              .toList();
        }
      }
      throw const FormatException('Unexpected response format');
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('API error ($status): $msg');
    }
  }

  /// GET /api/tickets (placeholder — endpoint not yet available)
  /// Returns a list of tickets available for booking.
  Future<List<Map<String, dynamic>>> getTickets() async {
    try {
      final resp = await _dio.get('/api/tickets');
      final data = resp.data;
      if (data is List) {
        return data.whereType<Map<String, dynamic>>().toList();
      }
      if (data is String) {
        final decoded = jsonDecode(data);
        if (decoded is List) {
          return decoded.whereType<Map<String, dynamic>>().toList();
        }
      }
      throw const FormatException('Unexpected response format');
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('API error ($status): $msg');
    }
  }

  /// GET /api/rooms (placeholder — endpoint not yet available)
  /// Returns a list of rooms available for booking.
  Future<List<Map<String, dynamic>>> getRooms() async {
    try {
      final resp = await _dio.get('/api/rooms');
      final data = resp.data;
      if (data is List) {
        return data.whereType<Map<String, dynamic>>().toList();
      }
      if (data is String) {
        final decoded = jsonDecode(data);
        if (decoded is List) {
          return decoded.whereType<Map<String, dynamic>>().toList();
        }
      }
      throw const FormatException('Unexpected response format');
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('API error ($status): $msg');
    }
  }

  /// GET /api/restaurants (placeholder — endpoint not yet available)
  /// Returns a list of restaurants available for reservation.
  Future<List<Map<String, dynamic>>> getRestaurants() async {
    try {
      final resp = await _dio.get('/api/restaurants');
      final data = resp.data;
      if (data is List) {
        return data.whereType<Map<String, dynamic>>().toList();
      }
      if (data is String) {
        final decoded = jsonDecode(data);
        if (decoded is List) {
          return decoded.whereType<Map<String, dynamic>>().toList();
        }
      }
      throw const FormatException('Unexpected response format');
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final msg = e.response?.data?.toString() ?? e.message;
      throw Exception('API error ($status): $msg');
    }
  }
}

class QuotationType {
  final int id;
  final String nameTh;
  final String nameEn;

  QuotationType({required this.id, required this.nameTh, required this.nameEn});

  factory QuotationType.fromJson(Map<String, dynamic> json) {
    return QuotationType(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      nameTh: (json['name_th'] ?? '').toString(),
      nameEn: (json['name_en'] ?? '').toString(),
    );
  }
}
